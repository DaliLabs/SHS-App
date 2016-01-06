//
//  ViewController.swift
//  MMGooglePlayNewsStand
//
//  Created by mukesh mandora on 25/08/15.
//  Copyright (c) 2015 madapps. All rights reserved.
//

var inTab = false
var justDismissedView = false

import UIKit

var spotlight_array : [Article] = []
var news_array : [Article] = []
var sports_array : [Article] = []
var opinion_array : [Article] = []
var columns_array : [Article] = []
var features_array : [Article] = []
var imageArr : [AnyObject] = []


class ViewController: UIViewController, MMPlayPageControllerDelegate {
let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
   
    @IBOutlet weak var showDemoBut: UIButton!
    /*
    override func viewWillAppear(animated: Bool) {
        getStoryNids("spotlight", count: "5") { nids in
            dispatch_async(dispatch_get_main_queue()) {
                for(var i = 0; i < nids.count; i++)
                {
                    getArticleForNid(nids[i] as! String) { article in
                        dispatch_async(dispatch_get_main_queue()) {
                            spotlight_array.append(article!)
                            getImage(article!.photoURL) { image in
                                imageArr.append(image!)
                            }
                            if(spotlight_array.count == nids.count)
                            {
                                self.initPlayStand()
                            }
                        }
                    }
                }
            }
        }
    }
*/
    override func viewDidAppear(animated: Bool) {
        inTab = true
        if(justDismissedView == true){
            inTab = false
            justDismissedView = false
            performSegueWithIdentifier("goToHome", sender: self)
        }
        viewDidLoad()
        print("true")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        if(columns_array.count == 0 && inTab == true){
            getStoryNids("spotlight", count: "5") { nids in
                dispatch_async(dispatch_get_main_queue()) {
                    for(var i = 0; i < nids.count; i++)
                    {
                        getArticleForNid(nids[i] as! String) { article in
                            dispatch_async(dispatch_get_main_queue()) {
                                spotlight_array.append(article!)
                                getImage(article!.photoURL) { image in
                                    imageArr.append(image!)
                                }
                                if(spotlight_array.count == nids.count)
                                {
                                    getStoryNids("news", count: "10") { nids in
                                        dispatch_async(dispatch_get_main_queue()) {
                                            for(var i = 0; i < nids.count; i++)
                                            {
                                                getArticleForNid(nids[i] as! String) { article in
                                                    dispatch_async(dispatch_get_main_queue()) {
                                                        news_array.append(article!)
                                                        if(news_array.count == nids.count)
                                                        {
                                                            getStoryNids("sports", count: "10") { nids in
                                                                dispatch_async(dispatch_get_main_queue()) {
                                                                    for(var i = 0; i < nids.count; i++)
                                                                    {
                                                                        getArticleForNid(nids[i] as! String) { article in
                                                                            dispatch_async(dispatch_get_main_queue()) {
                                                                                sports_array.append(article!)
                                                                                if(sports_array.count == nids.count)
                                                                                {
                                                                                    getStoryNids("opinion", count: "10") { nids in
                                                                                        dispatch_async(dispatch_get_main_queue()) {
                                                                                            for(var i = 0; i < nids.count; i++)
                                                                                            {
                                                                                                getArticleForNid(nids[i] as! String) { article in
                                                                                                    dispatch_async(dispatch_get_main_queue()) {
                                                                                                        opinion_array.append(article!)
                                                                                                        if(opinion_array.count == nids.count)
                                                                                                        {
                                                                                                            getStoryNids("columns", count: "10") { nids in
                                                                                                                dispatch_async(dispatch_get_main_queue()) {
                                                                                                                    for(var i = 0; i < nids.count; i++)
                                                                                                                    {
                                                                                                                        getArticleForNid(nids[i] as! String) { article in
                                                                                                                            dispatch_async(dispatch_get_main_queue()) {
                                                                                                                                columns_array.append(article!)
                                                                                                                                if(columns_array.count == nids.count)
                                                                                                                                {
                                                                                                                                    getStoryNids("features", count: "10") { nids in
                                                                                                                                        dispatch_async(dispatch_get_main_queue()) {
                                                                                                                                            for(var i = 0; i < nids.count; i++)
                                                                                                                                            {
                                                                                                                                                getArticleForNid(nids[i] as! String) { article in
                                                                                                                                                    dispatch_async(dispatch_get_main_queue()) {
                                                                                                                                                        features_array.append(article!)
                                                                                                                                                        if(features_array.count == nids.count)
                                                                                                                                                        {
                                                                                                                                                            self.initPlayStand()
                                                                                                                                                        }
                                                                                                                                                    }
                                                                                                                                                }
                                                                                                                                            }

                                                                                                                                        }
                                                                                                                                    }
                                                                                                                                }
                                                                                                                            }
                                                                                                                        }
                                                                                                                    }

                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }

                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }

                                                                }
                                                            }

                                                        }
                                                    }
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        else if(inTab == true){
            initPlayStand()
        }
       
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initPlayStand(){
        self.presentViewController(appDelegate.walkthrough!, animated: true, completion: nil)

        let stb = UIStoryboard(name: "Main", bundle: nil)
        
        
        let page_zero = stb.instantiateViewControllerWithIdentifier("stand_one") as! MMSampleTableViewController
        let page_one = stb.instantiateViewControllerWithIdentifier("stand_one") as! MMSampleTableViewController
        let page_two = stb.instantiateViewControllerWithIdentifier("stand_one")as! MMSampleTableViewController
        let page_three = stb.instantiateViewControllerWithIdentifier("stand_one") as! MMSampleTableViewController
        let page_four = stb.instantiateViewControllerWithIdentifier("stand_one") as! MMSampleTableViewController
        let page_five = stb.instantiateViewControllerWithIdentifier("stand_one") as! MMSampleTableViewController
        
        //header Color
        page_zero.tag=1
        page_one.tag=2
        page_two.tag=3
        page_three.tag=4
        page_four.tag=5
        page_five.tag=6
        
        // Attach the pages to the master
        appDelegate.walkthrough?.delegate = self
        appDelegate.walkthrough?.addViewControllerWithTitleandColor(page_zero, title: "Spotlight", color: UIColor(hexString: "9c27b0"))
        appDelegate.walkthrough?.addViewControllerWithTitleandColor(page_one, title: "News", color:UIColor(hexString: "009688"))
       
        appDelegate.walkthrough?.addViewControllerWithTitleandColor(page_two, title: "Sports", color:UIColor(hexString: "673ab7"))
        
        appDelegate.walkthrough?.addViewControllerWithTitleandColor(page_three, title: "Opinion", color: UIColor(hexString: "ff9800"))
        
         appDelegate.walkthrough?.addViewControllerWithTitleandColor(page_four, title: "Columns", color: UIColor(hexString: "03a9f4"))
        
        appDelegate.walkthrough?.addViewControllerWithTitleandColor(page_five, title: "Features", color: UIColor(hexString: "4caf50"))
        

    }

    @IBAction func showDemoAction(sender: AnyObject) {
        
        initPlayStand()
    }
    
    
}

