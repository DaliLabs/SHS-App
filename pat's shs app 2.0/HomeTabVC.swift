//
//  HomeTabVC.swift
//  Pat'sshsapp
//
//  Created by Patrick Li on 10/11/15.
//

import UIKit
import Parse

var internetConnection : Bool = true

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}



@IBDesignable class aboutView : UIView
{
    @IBOutlet var view: aboutView!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "aboutView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
  
    
}


class HomeTabVC: UIViewController, UITableViewDelegate, UITableViewDataSource, KenBurnsViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var aboutButton: UIButton!
    var anouncementsEventsArray = NSMutableArray()
    @IBOutlet weak var gradesButton: UIButton!
    var year = 0
    var month = 0
    var monthsLeft = 0
    var monthsArray = ["August", "September", "October", "November", "December",
        "January", "February", "March", "April", "May", "June", "July"]
    var popup : KLCPopup!

    
    override func viewWillAppear(animated: Bool) {
        tableView.delegate = self
        tableView.dataSource = self
        
        var date = NSDate()
        var calendar = NSCalendar.currentCalendar()
        var components = calendar.components(NSCalendarUnit.Year.union(NSCalendarUnit.Minute).union(NSCalendarUnit.Hour).union(NSCalendarUnit.Month).union(NSCalendarUnit.Day).union(NSCalendarUnit.Second), fromDate: date)
        self.month = components.month
        self.year = components.year
        
        if(Reachability.isConnectedToNetwork())
        {
            internetConnection = false
            var query = PFQuery(className: "Calendar")
            query.limit = 1000
            query.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                if error == nil {
                    // The find succeeded.
                    print("Successfully retrieved \(objects!.count) events.")
                    // Do something with the found objects
                    if let objects = objects as [PFObject]! {
                        for object in objects {
                            self.anouncementsEventsArray.addObject(object)
                        }
                        self.tableView.reloadData()
                    }
                    
                } else {
                    // Log details of the failure
                    print("hello?")
                    print("Error: \(error!) \(error!.userInfo)")
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
    
    @IBAction func gradesClicked(sender: AnyObject!)
    {
        let optionMenu = UIAlertController(title: nil, message: "Choose an Option For - Grades", preferredStyle: .ActionSheet)
        let navianceAction = UIAlertAction(title: "Naviance", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            let webVC = SwiftWebVC(urlString: "http://www.naviance.com/")
            self.navigationController?.pushViewController(webVC, animated: true)
        })
        let canvasAction = UIAlertAction(title: "Canvas", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            let webVC = SwiftWebVC(urlString: "https://lgsuhsd.instructure.com/")
            self.navigationController?.pushViewController(webVC, animated: true)
        })
        let aeriesAction = UIAlertAction(title: "Aeries", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            let webVC = SwiftWebVC(urlString: "https://aeries.lgsuhsd.org/aeries.net/loginparent.aspx")
            self.navigationController?.pushViewController(webVC, animated: true)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        
        optionMenu.addAction(canvasAction)
        optionMenu.addAction(aeriesAction)
        optionMenu.addAction(navianceAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func aboutClicked(sender: AnyObject) {
        let view = aboutView.instanceFromNib()
        popup = KLCPopup(contentView: view, showType: KLCPopupShowType.BounceIn, dismissType: KLCPopupDismissType.FadeOut, maskType: KLCPopupMaskType.Dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: true)
        popup.show()
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(month >= 8){
            self.monthsLeft = 19 - month
        }
        if(month <= 6){
            self.monthsLeft = 7 - month
        }
        print(monthsLeft)
        return self.monthsLeft
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        if(self.anouncementsEventsArray.count == 0)
        {
            if(Reachability.isConnectedToNetwork())
            {
                return "Loading Events..."
            }
            else
            {
                return ""
            }
        }
        for(var i=0; i<12; i++){
            if(i == section){
                return monthsArray[11-self.monthsLeft+i]
            }
        }
        return "loading"
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var tableViewCount = 0
        
        if (anouncementsEventsArray.count == 0){
            tableViewCount = 0
        }
        var indexOfCurMonth = 11 - monthsLeft
        
        for (var i=0; i<anouncementsEventsArray.count; i++)
        {
            print(self.anouncementsEventsArray[i].objectForKey("Month") as! String)
            if(StringMonthToNumMonth(monthsArray[indexOfCurMonth+section])
                == Int(self.anouncementsEventsArray[i].objectForKey("Month") as! String))
            {
                
                tableViewCount++
            }
            
        }
        return tableViewCount
    }
    
    func StringMonthToNumMonth(month: String) -> Int {
        switch month {
        case "January":
            return 1
        case "February":
            return 2
        case "March":
            return 3
        case "April":
            return 4
        case "May":
            return 5
        case "June":
            return 6
        case "July":
            return 7
        case "August":
            return 8
        case "September":
            return 9
        case "October":
            return 10
        case "November":
            return 11
        case "December":
            return 12
        default:
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func returnDayOfMonth(inputString: String) -> Int {
        let finalString = inputString[inputString.startIndex.advancedBy(3)..<inputString.startIndex.advancedBy(5)]
        return Int(finalString)!
    }
    
    func returnStartTime(inputString: String) -> String {
        var leftOfColon = inputString[inputString.startIndex.advancedBy(11)..<inputString.startIndex.advancedBy(13)]
        let rightOfColon = inputString[inputString.startIndex.advancedBy(14)..<inputString.startIndex.advancedBy(16)]
        var amOrPm = "AM"
        if(Int(leftOfColon) < 12){
            amOrPm = "AM"
            if(Int(leftOfColon) < 10){
                leftOfColon = String(Int(leftOfColon)!)
            }
        }
        else{
            amOrPm = "PM"
            leftOfColon = String(24 - Int(leftOfColon)!)
        }
        var finalString = leftOfColon + ":" + rightOfColon + " " + amOrPm
        if(Int(leftOfColon) == 0){
            finalString = "No Time"
        }
        return finalString
    }
    
    func returnDayOfWeek(inputString: String) -> String {
        let stringOfDate = inputString[inputString.startIndex.advancedBy(3)..<inputString.startIndex.advancedBy(5)]
        
        return ""
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AnounceEvents", forIndexPath: indexPath) as! AnounceEventsCell
        
        cell.name.text = String(self.anouncementsEventsArray[indexPath.row].objectForKey("Title")!)
        
        if let locationLabel = self.anouncementsEventsArray[indexPath.row].objectForKey("Description") {
            cell.locationLabel.text = locationLabel as? String
        }
        else{
            cell.locationLabel.text = "Location Unavailable"
        }
        cell.dayOfMonthLabel.text = String(returnDayOfMonth(self.anouncementsEventsArray[indexPath.row].objectForKey("Start")! as! String))
        
        cell.timeLabel.text = returnStartTime(self.anouncementsEventsArray[indexPath.row].objectForKey("Start")! as! String)
        
        return cell
        
    }
    
    
    
    
    
}
