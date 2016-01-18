//
//  TabBarControllerViewController.swift
//  pat's shs app 2.0
//
//  Created by Patrick Li on 10/12/15.
//  Copyright © 2015 Dali Labs, Inc. All rights reserved.
//


import UIKit

var showOrNot : Bool = false


class TabBarControllerViewController: UITabBarController, UITabBarControllerDelegate {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewWillAppear(animated: Bool) {
        let vc = appDelegate.walkthrough!
        let icon = UITabBarItem(title: "News", image: UIImage(imageLiteral: "newsTab"), selectedImage: nil)
        vc.tabBarItem = icon
        self.viewControllers?.append(vc)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
    }

    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
 
        return true
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
