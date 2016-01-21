//
//  NormalDetail.swift
//  MMGooglePlayNewsStand
//
//  Created by Daniel Bessonov on 12/31/15.
//  Copyright © 2015 madapps. All rights reserved.
//

import UIKit

class NormalDetail: UIViewController {

    @IBOutlet weak var textViewDemo: UITextView!
    var navBar = UIView()
    var dismissFrame = CGRectMake(0, 0, 0, 0)
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewDidLoad() {
        SwiftSpinner.hide()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //textHeightConstraint.constant = 2000
        let navBut = UIButton(type: UIButtonType.System)
        let navTitle = UILabel()
        textViewDemo.scrollEnabled = true
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
    


}
