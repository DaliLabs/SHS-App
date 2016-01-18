//
//  GetNewsClient.swift
//  NewsVersion1
//
//  Created by Daniel Bessonov on 11/8/15.
//  Copyright © 2015 Daniel Bessonov. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

extension NSMutableURLRequest {
    func setBodyContent(contentMap: Dictionary<String, String>) {
        var firstOneAdded = false
        var contentBodyAsString = String()
        let contentKeys:Array<String> = Array(contentMap.keys)
        for contentKey in contentKeys {
            if(!firstOneAdded) {
                
                contentBodyAsString = contentBodyAsString + contentKey + "=" + contentMap[contentKey]!
                firstOneAdded = true
            }
            else {
                contentBodyAsString = contentBodyAsString + "&" + contentKey + "=" + contentMap[contentKey]!
            }
        }
        contentBodyAsString = contentBodyAsString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        self.HTTPBody = contentBodyAsString.dataUsingEncoding(NSUTF8StringEncoding)
    }
}

import Foundation
import SystemConfiguration


class Article : NSObject
{
    var nid : String;
    var title : String;
    var author : String;
    var body : String;
    var date : String;
    var section : String;
    var photoURL : String;
    var imageSubtitle : String;
    
    init(id: String, title : String, author : String, body : String, date : String, section : String, photoURL : String,
        imageSubtitle : String)
    {
        self.nid = id
        self.title = title
        self.author = author
        self.body = body
        self.date = date
        self.section = section
        self.photoURL = photoURL
        self.imageSubtitle = imageSubtitle
    }
    
}


public class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}

// Section is, for example: Sports, opnion, spotlight, etc;.
// Count is how many stories you want. (Ex: getStoryNids("sports", "4") would give you the
// 4 most recent stories.

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


func getStoryNids(section: String, count : String, completion : ((nids : [AnyObject]) -> Void)){
    var articles : [Article] = [];
    let url = NSURL(string: "http://www.saratogafalcon.org/ws/")
    let parameters = ["request_type":"get_story_nids", "story_type":"\(section)", "story_number" : "\(count)"] as Dictionary<String, String>
    
    //create the session object
    let session = NSURLSession.sharedSession()
    let request = NSMutableURLRequest(URL: url!)
    request.HTTPMethod = "POST"
    
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setBodyContent(parameters)
    
    let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
        if(data != nil)
        {
            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            strData = strData.stringByReplacingOccurrencesOfString("[", withString: "")
            strData = strData.stringByReplacingOccurrencesOfString("]", withString: "")
            strData = strData.stringByReplacingOccurrencesOfString("\"", withString: "")
            var nids : [AnyObject] = strData.componentsSeparatedByString(",")
            completion(nids: nids)
        }
        
        else if(data == nil)
        {


        }
        /*
        for(var i = 0; i < nids.count; i++)
        {
        getArticleForNid(nids[i] as! String)
        if(i == nids.count-1)
        {
        
        }
        }
        */
        
        else if(error != nil) {
            print(error!.localizedDescription)
            if(data != nil)
            {
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
                completion(nids: [])
            }
        }
        
    })
    
    task.resume()
}


func getArticleForNid(nid : String, completion : ((article : Article?) -> Void))
{
    let url = NSURL(string: "http://www.saratogafalcon.org/ws/")
    let parameters = ["request_type" : "get_story_details", "story_nid" : "\(nid)"] as Dictionary<String, String>
    
    //create the session object
    let session = NSURLSession.sharedSession()
    let request = NSMutableURLRequest(URL: url!)
    request.HTTPMethod = "POST"
    
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setBodyContent(parameters)
    
    let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
        
        if(error != nil) {
            print(error!.localizedDescription)
            let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Error could not parse JSON: '\(jsonStr)'")
            completion(article: nil)
        }
        
        let articleDict : NSDictionary = try!NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as! NSDictionary
        let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)!
        let timeFormatter : NSDateFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "YYYY-MM-DD hh:mm:ss"
        timeFormatter.locale = NSLocale(localeIdentifier: "en_US")
        timeFormatter.timeZone = NSTimeZone(name: "PST")
        let dateFromString : NSDate = timeFormatter.dateFromString(articleDict.objectForKey("date") as! String)!
        let stringFormatter : NSDateFormatter = NSDateFormatter()
        stringFormatter.dateFormat = "M/dd/yy"
        stringFormatter.locale = NSLocale(localeIdentifier: "en_US")
        stringFormatter.timeZone = NSTimeZone(name: "PST")
        let newDate: String = stringFormatter.stringFromDate(dateFromString)
        let article : Article = Article(id: articleDict.objectForKey("nid") as! String, title: articleDict.objectForKey("title") as! String, author: articleDict.objectForKey("author") as! String, body: articleDict.objectForKey("story") as! String, date: newDate, section: articleDict.objectForKey("storyType") as! String, photoURL: articleDict.objectForKey("imageURL") as! String, imageSubtitle: articleDict.objectForKey("imageSubtitle") as! String)
        completion(article: article)
        
    })
    
    task.resume()
}

func getImage(url1 : String, completion : ((image : UIImage?) -> Void))
{
    if let url = NSURL(string: url1) {
        if let data = NSData(contentsOfURL: url) {
            completion(image: UIImage(data: data)!)
        }
    }
}

func randomInt(min: Int, max:Int) -> Int {
    return min + Int(arc4random_uniform(UInt32(max - min + 1)))
}

//number is a workaround - get "Immutable" error if passing article straight through
func loadArticles(art : [Article], type : String , completion : ((done : Bool?) -> Void))
{
    
    var currentArt = art
    print(art)
    getStoryNids(type, count: "10") { nids in
        dispatch_async(dispatch_get_main_queue()) {
            for(var i = 0; i < nids.count; i++)
            {
                getArticleForNid(nids[i] as! String) { article in
                    dispatch_async(dispatch_get_main_queue()) {
                        currentArt.append(article!)
                        getImage(article!.photoURL) { image in
                            imageArr.append(image!)
                        }
                        print(currentArt)
                        if((currentArt.count == nids.count) && (type == "features"))
                        {
                            completion(done: true)
                        }
                    }
                }
            }
            
        }
    }
}



