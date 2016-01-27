//
//  listViewController.swift
//  Directory
//
//  Created by Daniel Bessonov on 1/3/16.
//  Copyright © 2016 Daniel Bessonov. All rights reserved.
//

import UIKit
import Parse

class staffMember : NSObject {
    var name : String
    var type : String
    var email : String
    var website : String
    init(name : String, type : String, email : String, website : String)
    {
        self.name = name
        self.type = type
        self.email = email
        self.website = website
    }
}

//point of staffMember is to help with SearchBar

extension listViewController : UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class listViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var allStaff = NSMutableArray()
    var selectedStaff : staffMember = staffMember(name: "", type: "", email : "", website : "")
    

    @IBOutlet weak var listView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var staffMembers = [staffMember]()
    var filteredStaff = [staffMember]()
    
    override func viewWillAppear(animated: Bool) {

        if(Reachability.isConnectedToNetwork())
        {
            var query = PFQuery(className: "Staff")
            query.limit = 1000
            if(self.allStaff.count == 0)
            {
                query.findObjectsInBackgroundWithBlock {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    if error == nil {
                        // The find succeeded.
                        print("Successfully retrieved \(objects!.count) events.")
                        // Do something with the found objects
                        if let objects = objects as [PFObject]! {
                            for object in objects {
                                self.allStaff.addObject(object)
                            }
                            
                        } else {
                            // Log details of the failure
                            print("Error: \(error!) \(error!.userInfo)")
                        }
                        for(var i = 0; i < self.allStaff.count; i++)
                        {
                            self.staffMembers.append(staffMember(name: self.allStaff[i].objectForKey("Name") as! String, type: self.allStaff[i].objectForKey("Type") as! String, email : self.allStaff[i].objectForKey("Email") as! String, website : self.allStaff[i].objectForKey("Website") as! String))
                            if(self.allStaff.count == self.staffMembers.count)
                            {
                                self.listView.reloadData()
                            }
                        }
                        
                    }
                }
            }
        }
        else
        {
            let alert = UIAlertController(title: "No Internet", message: "We've detected that you aren't connected to the internet. Please close the app and try again. Note that some features will not work without internet access.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listView.delegate = self
        self.listView.dataSource = self
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.listView.addSubview(self.searchController.searchBar)
        self.searchController.searchBar.sizeToFit()
        self.searchController.searchBar.frame.size.width = self.view.frame.size.width
        
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        self.filteredStaff = self.staffMembers.filter ({ staff -> Bool in
            return staff.name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
        })
        
        self.filteredStaff = self.staffMembers.filter({ (text) -> Bool in
            let tempString:  NSString = text.name
            let range = tempString.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        
        self.listView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != ""
        {
            return self.filteredStaff.count
        }
        return self.staffMembers.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("utilityCell", forIndexPath: indexPath) as! utilityCell
        if self.allStaff.count == 0
        {
            cell.useText("Loading...", text2: "")
        }
        else if searchController.active && searchController.searchBar.text != ""
        {
            cell.useStaff(self.filteredStaff[indexPath.row])
        }
        else
        {
            cell.useStaff(self.staffMembers[indexPath.row])
        }
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.listView.deselectRowAtIndexPath(indexPath, animated: true)
        if searchController.active && searchController.searchBar.text != ""
        {
            self.selectedStaff = self.filteredStaff[indexPath.row]
        }
        else
        {
        self.selectedStaff = self.staffMembers[indexPath.row]
        }
        let optionMenu = UIAlertController(title: nil, message: "\(self.selectedStaff.name)", preferredStyle: .ActionSheet)
        let deleteAction = UIAlertAction(title: "Email Teacher", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            let url = NSURL(string : "mailto:\(self.selectedStaff.email)")
            UIApplication.sharedApplication().openURL(url!)
        })
        let saveAction = UIAlertAction(title: "Go to Website", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            let webVC = SwiftWebVC(urlString: "\(self.selectedStaff.website)")
            self.navigationController?.pushViewController(webVC, animated: true)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)

        //print(self.filteredStaff[indexPath.row])
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
