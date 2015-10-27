//
//  HomeTabVC.swift
//  Pat'sshsapp
//
//  Created by Patrick Li on 10/11/15.
//  Copyright © 2015 Evan Dekhayser. All rights reserved.
//

import UIKit

class HomeTabVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

   @IBOutlet weak var tableView: UITableView!
   var AnouncementsEventsArray: NSMutableArray!

   override func viewDidLoad() {
      super.viewDidLoad()

      tableView.delegate = self
      tableView.dataSource = self

      /*
      parse shit
      */

   }

   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 8;
   }

   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("Announcement", forIndexPath: indexPath) as! AnnouncementCellTableViewCell
      return cell;

   }

   
}
