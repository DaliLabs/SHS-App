//
//  ManagerTableViewController.swift
//  Planner
//
//  Created by Daniel Bessonov on 11/7/15.
//  Copyright © 2015 Daniel Bessonov. All rights reserved.
//

import UIKit

/*
NSUserDefaults.standardUserDefaults().setInteger(highScore, forKey: "highscore")
NSUserDefaults.standardUserDefaults().synchronize()
*/

protocol JSONAble {}

extension JSONAble {
    func toDict() -> [String:Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
}

var numOfViewWillAppear : Int = 0

class PlannerVC: UITableViewController {
    
    var sections = Dictionary<String, Array<Assignment>>()
    var sortedSections = [String]()
    var plistPath : String!
    var plistPath2 : String!
    
    override func viewWillAppear(animated: Bool) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        plistPath = appDelegate.plistPathInDocument
        plistPath2 = appDelegate.plist2PathInDocument
        // Extract the content of the file as NSData
        let data:NSData =  NSFileManager.defaultManager().contentsAtPath(plistPath)!
        let data2:NSData = NSFileManager.defaultManager().contentsAtPath(plistPath2)!
        do{
            if(numOfViewWillAppear == 0)
            {
        
                if let x = NSKeyedUnarchiver.unarchiveObjectWithData(data2)
                {
                    self.sortedSections = NSKeyedUnarchiver.unarchiveObjectWithData(data2) as! [String]
                    self.sections = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Dictionary
                }
                numOfViewWillAppear++
            }
    
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func unwindAndAddToList(segue: UIStoryboardSegue) {
        
        let source = segue.sourceViewController as! AddAssignmentViewController
        let todoItem : Assignment = source.assignment
        if todoItem.name != "" {
            if(self.sections.indexForKey(todoItem.dueDate) == nil)
            {
                self.sections[todoItem.dueDate] = [Assignment(name: todoItem.name, dueDate: todoItem.dueDate)]
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                plistPath = appDelegate.plistPathInDocument
                do{
                    let sectionsData = NSKeyedArchiver.archivedDataWithRootObject(sections)
                    sectionsData.writeToFile(plistPath, atomically: true)
                }
            }
            else
            {
                self.sections[todoItem.dueDate]!.append(Assignment(name: todoItem.name, dueDate: todoItem.dueDate))
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                plistPath = appDelegate.plistPathInDocument
                do {
                    let sectionsData = NSKeyedArchiver.archivedDataWithRootObject(sections)
                    sectionsData.writeToFile(plistPath, atomically: true)
                }
            }
            self.sortedSections = self.sections.keys.sort()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            plistPath2 = appDelegate.plist2PathInDocument
            do {
                let sortedData = NSKeyedArchiver.archivedDataWithRootObject(self.sortedSections)
                sortedData.writeToFile(plistPath2, atomically: true)
            }
    
        }
        self.tableView.reloadData()
        
    }


    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        /*
        let tappedItem = todoItems[indexPath.row] as Assignment
        tappedItem.done = !tappedItem.done
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        */
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell", forIndexPath: indexPath)
        let tableSection = sections[sortedSections[indexPath.section]]
        let tableItem = tableSection![indexPath.row]
        cell.textLabel?.text = tableItem.name
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            var tableSection = sections[sortedSections[indexPath.section]]
            tableSection!.removeAtIndex(indexPath.row)
            sections[sortedSections[indexPath.section]] = tableSection
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            plistPath = appDelegate.plistPathInDocument
            plistPath2 = appDelegate.plist2PathInDocument
            do {
                let sectionsData = NSKeyedArchiver.archivedDataWithRootObject(sections)
                sectionsData.writeToFile(plistPath, atomically: true)
                let sortedData = NSKeyedArchiver.archivedDataWithRootObject(sortedSections)
                sortedData.writeToFile(plistPath2, atomically: true)
            }
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(sections[sortedSections[section]]!.count == 0)
        {
            return ""
        }
        else
        {
            return sortedSections[section]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[sortedSections[section]]!.count
    }
    
}

