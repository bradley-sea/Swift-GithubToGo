//
//  NetworkController.swift
//  Swift-GithubToGo
//
//  Created by Bradley Johnson on 6/5/14.
//  Copyright (c) 2014 Bradley Johnson. All rights reserved.
//

import UIKit

class NetworkController: NSObject {
    
    let GITHUB_CLIENT_ID = "client_id=b44b4d51dff4208800d0&"
    let GITHUB_CLIENT_SECRET = "dfc5f54502dc651cea4dc8bb8b006cc1e1aff7fb"
    let GITHUB_CALLBACK_URI = "redirect_uri=swift-githubtogo://git_callback&"
    let GITHUB_OAUTH_URL = "https://github.com/login/oauth/authorize?"
    let GITHUB_API_URL = "https://api.github.com/"
    let GITHUB_SCOPE = "scope=user,repo"
    
    var completion:() -> () = {}
    var urlSession = NSURLSession()
    var token : String?

    
   init() {
    
     var userDefaults = NSUserDefaults.standardUserDefaults()
     self.token = userDefaults.objectForKey("token") as String
    
    if self.token {
        println(self.token)
        var configuration = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        configuration.HTTPAdditionalHeaders = ["Authorization" : "token \(self.token)"]
        self.urlSession = NSURLSession(configuration: configuration)
        
    } else {
    
    var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    self.urlSession = NSURLSession(configuration: configuration)
    }
    
    }
    
    func requestOauthAccessWithCompletion(completionClosure: () -> ()) {
        self.completion = completionClosure
        var urlString : String = GITHUB_OAUTH_URL + GITHUB_CLIENT_ID + GITHUB_CALLBACK_URI + GITHUB_SCOPE
        UIApplication.sharedApplication().openURL(NSURL(string: urlString))
    }
    
    func retrieveMyReposWithCompletion(completionClosure: (repos :Repo[]) ->()) {
        
        var request = NSMutableURLRequest(URL: NSURL(string: "https://api.github.com/user/repos"))
        request.HTTPMethod = "GET"
        
        let postDataTask = self.urlSession.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            if error {
                println(error.localizedDescription)
            }
            println(response)
            var repoJSON : NSMutableArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSMutableArray
            
            var repos : Repo[] = Repo().parseJSONIntoRepos(repoJSON)
            println(repos.count)
            
            completionClosure(repos: repos)
            
            })
        postDataTask.resume()
        
        
    }
    
    func handleOauthCallbackWithURL(url : NSURL)
    {
        
        var code = self.parseCodeFromCallbackURL(url)
        var postQuery = GITHUB_CLIENT_ID + "client_secret=" + GITHUB_CLIENT_SECRET + "&code=\(code)"
        var postData = postQuery.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        var postLength = "\(postData.length)"
        
        //setup our post request
        var request = NSMutableURLRequest(URL: NSURL(string: "https://github.com/login/oauth/access_token"))
            request.HTTPMethod = "POST"
            request.setValue(postLength, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = postData
        
        let postDataTask = self.urlSession.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            if error {
                println(error.localizedDescription)
            }
            self.token = self.convertOauthResponseData(data)
            NSUserDefaults.standardUserDefaults().setObject(self.token, forKey: "token")
            println(self.token)
            var config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
            config.HTTPAdditionalHeaders = ["Authorization" : "token \(self.token)"]
            self.urlSession = NSURLSession(configuration: config)
            println(self.token)
            self.completion()
            })
        postDataTask.resume()
    }
    
    func parseCodeFromCallbackURL(callbackUrl : NSURL) -> String {
        
        var query = callbackUrl.query
        var components = query.componentsSeparatedByString("code=") as String[]
        return components[components.count - 1]
    }
    
    func convertOauthResponseData(data : NSData) -> String {
//        var tokenResponse = "\(data)"
        var tokenResponse = NSString(data:data, encoding: NSASCIIStringEncoding)
        var tokenComponents = tokenResponse.componentsSeparatedByString("&") as String[]
        var accessTokenWithCode = tokenComponents[0]
        var accessTokens = accessTokenWithCode.componentsSeparatedByString("=") as String[]
        return accessTokens[1]
        
    }
   
}
