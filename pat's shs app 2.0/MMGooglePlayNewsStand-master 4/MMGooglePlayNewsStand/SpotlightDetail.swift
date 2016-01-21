//
//  DetailViewController.swift
//  MMGooglePlayNewsStand
//
//  Created by mukesh mandora on 27/08/15.
//  Copyright (c) 2015 madapps. All rights reserved.
//

import UIKit

let htmlReplaceString : String  = "<[^>]+>"

extension String {
    func stripHTML() -> String {
        return self.stringByReplacingOccurrencesOfString(htmlReplaceString, withString: "", options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
    }
}



class DetailViewController: UIViewController {

    @IBOutlet weak var textViewDemo: UITextView!
    @IBOutlet weak var textHeightConstraint: NSLayoutConstraint!
    var navBar = UIView()
    var dismissFrame = CGRectMake(0, 0, 0, 0)
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewDidLoad() {
        SwiftSpinner.hide()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //textHeightConstraint.constant = textViewDemo.frame.size.height
        textViewDemo.scrollEnabled = true
        print(textViewDemo.frame.size.height)
        let navBut = UIButton(type: UIButtonType.System)
        let navTitle = UILabel()
        navBar.frame=CGRectMake(0, 0, self.view.bounds.width, 64)
        navBut.frame=CGRectMake(0, 16, 45, 45)
        navTitle.frame=CGRectMake(55 , 20, self.view.bounds.width-50, 30)
        
        navBar.backgroundColor = UIColor(hexString: "673ab7")
        navBut.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        navBut.tintColor=UIColor.whiteColor()
        navBut.setImage(UIImage(named: "back")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
        navBut.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        navTitle.textColor=UIColor.whiteColor()
        navTitle.font=UIFont(name: "Roboto-Medium", size: 20)
        navTitle.text="Detail Page"
        textViewDemo.text = bodyToPass.stripHTML()
        textViewDemo.font = UIFont(name: "Helvetica-Light", size: CGFloat(15))
        titleLabel.text = titleToPass
        authorLabel.text = "By \(authorToPass)"
        getImage(imageToPass) {image in
            self.imageView.image = image
        }
        navBar.addSubview(navBut)
        navBar.addSubview(navTitle)
        view.addSubview(navBar)
        
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
