//
//  DetailViewController.swift
//  MMGooglePlayNewsStand
//
//  Created by mukesh mandora on 27/08/15.
//  Copyright (c) 2015 Daniel Bessonov. All rights reserved.
//

import UIKit

let htmlReplaceString : String  = "<[^>]+>"

extension String {
    func stripHTML() -> String {
        return self.stringByReplacingOccurrencesOfString(htmlReplaceString, withString: "", options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
    }
}


extension String {
    func isEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "2016",
            options: [.CaseInsensitive])
        
        return regex.firstMatchInString(self, options:[],
            range: NSMakeRange(0, utf16.count)) != nil
    }
}

class DetailViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var shsTvButton: UIButton!
    @IBOutlet weak var textViewDemo: UITextView!
    @IBOutlet weak var textHeightConstraint: NSLayoutConstraint!
    var navBar = UIView()
    var dismissFrame = CGRectMake(0, 0, 0, 0)
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var modalClicked : Bool = false
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        self.shsTvButton.hidden = true
        textViewDemo.scrollRangeToVisible(NSMakeRange(0, 0))
        self.textViewDemo.delegate = self
        self.textViewDemo.dataDetectorTypes = UIDataDetectorTypes.Link
        self.textViewDemo.setContentOffset(CGPointZero, animated: false)
        if(bodyToPass.rangeOfString("\(channelUrl)") != nil || modalClicked == true)
        {
            bodyToPass = ""
            self.textViewDemo.text = ""
            self.shsTvButton.hidden = false
        }
    }
    
    
    override func viewDidLoad() {
        SwiftSpinner.hide()
        super.viewDidLoad()
        textViewDemo.scrollEnabled = true
        let navBut = UIButton(type: UIButtonType.System)
        let navTitle = UILabel()
        navBar.frame=CGRectMake(0, 0, self.view.bounds.width, 64)
        navBut.frame=CGRectMake(0, 16, 45, 45)
        navTitle.frame=CGRectMake(self.view.bounds.width / 3 + self.view.bounds.width / 15,navBar.bounds.height / 2.75, self.view.bounds.width-70, 30)
        navBar.backgroundColor = UIColor(hexString: "673ab7")
        navBut.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        navBut.tintColor=UIColor.whiteColor()
        navBut.setImage(UIImage(named: "close47")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
        navBut.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        navTitle.textColor=UIColor.whiteColor()
        navTitle.font=UIFont(name: "Roboto-Medium", size: 20)
        navTitle.text = "\(sectionToPass)"
        if(bodyToPass.rangeOfString("\(channelUrl)") == nil)
        {
            textViewDemo.text = bodyToPass.stripHTML()
        }
        textViewDemo.font = UIFont(name: "Helvetica-Light", size: CGFloat(15))
        textViewDemo.scrollIndicatorInsets = UIEdgeInsetsZero
        titleLabel.text = titleToPass
        authorLabel.text = "By \(authorToPass)"
        getImage(imageToPass) {image in
            self.imageView.image = image
        }
        navBar.addSubview(navBut)
        navBar.addSubview(navTitle)
        view.addSubview(navBar)
        
    }
    
    @IBAction func shsTvButtonClicked(sender: AnyObject) {
        let webVC = SwiftModalWebVC(urlString: "\(channelUrl)")
        modalClicked = true
        self.presentViewController(webVC, animated: true, completion: nil)
    }
    
    func dismiss(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
