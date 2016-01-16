//
//  ManagerTableViewController.swift
//  Planner
//
//  Created by Daniel Bessonov on 11/7/15.
//  Copyright © 2015 Daniel Bessonov. All rights reserved.
//

import UIKit

var number_of_sections : Int = 0

/*
NSUserDefaults.standardUserDefaults().setInteger(highScore, forKey: "highscore")
NSUserDefaults.standardUserDefaults().synchronize()

*/

class PlannerVC: UITableViewController {
    
    var todoItems : [Assignment] = []
    var sections = Dictionary<String, Array<Assignment>>()
    var sortedSections = [String]()
    
    @IBAction func unwindAndAddToList(segue: UIStoryboardSegue) {
        
        let source = segue.sourceViewController as! AddAssignmentViewController
        let todoItem : Assignment = source.assignment
        if todoItem.name != "" {
            self.todoItems.append(todoItem)
            if(self.sections.indexForKey(todoItem.dueDate) == nil)
            {
                number_of_sections++
                self.sections[todoItem.dueDate] = [Assignment(name: todoItem.name, dueDate: todoItem.dueDate)]
            }
            else
            {
                self.sections[todoItem.dueDate]!.append(Assignment(name: todoItem.name, dueDate: todoItem.dueDate))
            }
            
            self.sortedSections = self.sections.keys.sort()
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

