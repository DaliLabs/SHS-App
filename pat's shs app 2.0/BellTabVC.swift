//
//  BellTabVC.swift
//  Pat'sshsapp
//
//  Created by Patrick Li on 10/11/15.
//  Copyright © 2015 Evan Dekhayser. All rights reserved.
//

import UIKit



class BellTabVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
   @IBOutlet weak var progressBar: UIProgressView!
   @IBOutlet weak var segmentBarDays: UISegmentedControl!
   @IBOutlet weak var timeBar: UILabel!
   @IBOutlet weak var timeBarLabel: UILabel!
   @IBOutlet weak var segmentBar: UILabel!
   @IBOutlet weak var tableView1: UITableView!
   var timesArray: [String]! = []
   var periodArray: [String]! = []
   var currTime = 0
   var currDate = 0
   var hour = 0
   var tempHour = 0;
   var amOrPm = ""
   var minutes = 0
   var second = 0
   var date = NSDate()
   var calendar = NSCalendar.currentCalendar()

   // times
   var mondayHours: [Int] = []
   var mondayMinutes: [Int] = []
   var tuesdayHours: [Int] = []
   var tuesdayMinutes: [Int] = []
   var wednesdayHours: [Int] = []
   var wednesdayMinutes: [Int] = []
   var thursdayHours: [Int] = []
   var thursdayMinutes: [Int] = []
   var fridayHours: [Int] = []
   var fridayMinutes: [Int] = []

   override func viewDidLoad() {
      super.viewDidLoad()

      tableView1.delegate = self
      tableView1.dataSource = self

      date = NSDate()
      calendar = NSCalendar.currentCalendar()
      var components = calendar.components(NSCalendarUnit.Year.union(NSCalendarUnit.Minute).union(NSCalendarUnit.Hour).union(NSCalendarUnit.Month).union(NSCalendarUnit.Day).union(NSCalendarUnit.Second), fromDate: date)
      self.hour = components.hour
      self.minutes = components.minute
      self.second = components.second
      let month = components.month
      let year = components.year
      var day = components.day


      let currDate = "\(year)-\(month)-\(day)"
      print(3)
      var dayOfWeek = getDayOfWeek(currDate)

      if(dayOfWeek == 2){
         segmentBarDays.selectedSegmentIndex = 0
         setTableView("M")
      }
      else if(dayOfWeek == 3){
         segmentBarDays.selectedSegmentIndex = 1
         setTableView("T")

      }
      else if(dayOfWeek == 4){
         segmentBarDays.selectedSegmentIndex = 2
         setTableView("W")

      }
      else if(dayOfWeek == 5){
         segmentBarDays.selectedSegmentIndex = 3
         setTableView("TH")

      }
      else if(dayOfWeek == 6){
         segmentBarDays.selectedSegmentIndex = 4
         setTableView("F")

      }
      else {
         setTableView("M")
      }

      tempHour = components.hour
      if(hour > 12){
         tempHour = hour - 12
         amOrPm = "P.M."
      }
      else{
         amOrPm = "A.M."
      }
      timeBarLabel.textAlignment = .Center



      scheduledTimerWithTimeInterval()

      progressBar.progress = 0
      NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("testUpdate"), userInfo: nil, repeats: true)
   }

   func testUpdate(){

      progressBar.setProgress(100, animated: true)
   }

   func scheduledTimerWithTimeInterval(){
      NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
   }

   func update(){
      date = NSDate()
      calendar = NSCalendar.currentCalendar()
      let components = calendar.components(NSCalendarUnit.Year.union(NSCalendarUnit.Minute).union(NSCalendarUnit.Hour).union(NSCalendarUnit.Month).union(NSCalendarUnit.Day).union(NSCalendarUnit.Second), fromDate: date)
      if(components.day == 2){

         for(var i=0; i<timesArray.count; i=i+2){
            if(hour >= mondayHours[i] && hour <= mondayHours[i+1] && minutes >= mondayMinutes[i] && minutes <= mondayMinutes[i+1]){
               if(i==0){
                  timeBarLabel.text = "Period 1"
               }
               else if(i==1){
                  timeBarLabel.text = "Period 2"

               }
               else if(i==2){
                  timeBarLabel.text = "Tutorial!"

               }
               else if(i==3){
                  timeBarLabel.text = "Period 3"

               }
               else if(i==4){
                  timeBarLabel.text = "Period 4"

               }
               else if(i==5){
                  timeBarLabel.text = "Lunch Time!"

               }
               else if(i==6){
                  timeBarLabel.text = "Period 5"

               }
               else if(i==7){
                  timeBarLabel.text = "Period 6"

               }
               else if(i==8){
                  timeBarLabel.text = "Period 7"

               }
            }
            else{
               print("stuff")
               timeBarLabel.text = "School's Out!"
            }
         }

      }
      else if(components.day == 3){

         for(var i=0; i<timesArray.count; i=i+2){
            if(hour >= tuesdayHours[i] && hour <= tuesdayHours[i+1] && minutes >= tuesdayMinutes[i] && minutes <= tuesdayMinutes[i+1]){
               if(i==0){
                  timeBarLabel.text = "Period 1"
               }
               else if(i==1){
                  timeBarLabel.text = "Break!"

               }
               else if(i==2){
                  timeBarLabel.text = "Period 2"

               }
               else if(i==3){
                  timeBarLabel.text = "Lunch!"

               }
               else if(i==4){
                  timeBarLabel.text = "Period 3"

               }
               else if(i==5){
                  timeBarLabel.text = "Period 7"

               }
            }
            else{
               print("stuff")
               timeBarLabel.text = "School's Out!"
            }
         }

      }
      else if(components.day == 4){

         for(var i=0; i<timesArray.count; i=i+2){
            if(hour >= wednesdayHours[i] && hour <= wednesdayHours[i+1] && minutes >= wednesdayMinutes[i] && minutes <= wednesdayMinutes[i+1]){
               if(i==0){
                  timeBarLabel.text = "Period 4"
               }
               else if(i==1){
                  timeBarLabel.text = "Break!"

               }
               else if(i==2){
                  timeBarLabel.text = "Period 5"

               }
               else if(i==3){
                  timeBarLabel.text = "Lunch!"

               }
               else if(i==4){
                  timeBarLabel.text = "Period 6"

               }
               else if(i==5){
                  timeBarLabel.text = "Tutorial!"

               }
            }
            else{
               print("stuff")
               timeBarLabel.text = "School's Out!"
            }
         }
      }
      else if(components.day == 5){

         for(var i=0; i<timesArray.count; i=i+2){
            if(hour >= thursdayHours[i] && hour <= thursdayHours[i+1] && minutes >= thursdayMinutes[i] && minutes <= thursdayMinutes[i+1]){
               if(i==0){
                  timeBarLabel.text = "Period 1"
               }
               else if(i==1){
                  timeBarLabel.text = "Break!"

               }
               else if(i==2){
                  timeBarLabel.text = "Period 2"

               }
               else if(i==3){
                  timeBarLabel.text = "Lunch!"

               }
               else if(i==4){
                  timeBarLabel.text = "Period 3"

               }
               else if(i==5){
                  timeBarLabel.text = "Period 7"

               }
            }
            else{
               print("stuff")
               timeBarLabel.text = "School's Out!"
            }
         }


      }
      else if(components.day == 6){

         for(var i=0; i<timesArray.count; i=i+2){
            if(hour >= fridayHours[i] && hour <= fridayHours[i+1] && minutes >= fridayMinutes[i] && minutes <= fridayMinutes[i+1]){
               if(i==0){
                  timeBarLabel.text = "Period 4"
               }
               else if(i==1){
                  timeBarLabel.text = "Tutorial!"

               }
               else if(i==2){
                  timeBarLabel.text = "Break!"

               }
               else if(i==3){
                  timeBarLabel.text = "Period 5"

               }
               else if(i==4){
                  timeBarLabel.text = "Lunch!"

               }
               else if(i==5){
                  timeBarLabel.text = "Period 6"

               }
            }
            else{
               print("stuff")
               timeBarLabel.text = "School's Out!"
            }
         }

      }

   }

   func getDayOfWeek(today:String)->Int {

      let formatter  = NSDateFormatter()
      formatter.dateFormat = "yyyy-MM-dd"
      let todayDate = formatter.dateFromString(today)!
      let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
      let myComponents = myCalendar.components(.Weekday, fromDate: todayDate)
      let weekDay = myComponents.weekday
      return weekDay
   }

   @IBAction func daySelected(sender: AnyObject) {
      switch sender.selectedSegmentIndex {
      case 0:
         setTableView("M")
      case 1:
         setTableView("T")
      case 2:
         setTableView("W")
      case 3:
         setTableView("TH")
      case 4:
         setTableView("F")

      default:
         break;
      }
   }

   func setHoursAndMinutes(day: String, time: String){
      var originalString = time
      let dashIndex = originalString.lowercaseString.characters.indexOf("-")
      let dashIndexString = "\(dashIndex!)"
      let DashIndexInt = Int(dashIndexString)!

      //---------------------------------------

      //left of dash
      let leftOfDashRange = originalString.startIndex.advancedBy(0)..<originalString.startIndex.advancedBy(DashIndexInt-1)
      //let leftOfDashRange = advance(originalString.startIndex, 0)..<advance(originalString.startIndex, DashIndexInt-1)
      let leftOfDashString = originalString[leftOfDashRange]
      print(leftOfDashString)


      let colonIndex = leftOfDashString.lowercaseString.characters.indexOf(":")
      let colonIndexString = "\(colonIndex!)"
      let colonIndexInt = Int(colonIndexString)!

      //left of colon
      let leftOfColonRange = leftOfDashString.startIndex.advancedBy(0)..<leftOfDashString.startIndex.advancedBy(colonIndexInt)
      //let leftOfColonRange = advance(leftOfDashString.startIndex, 0)..<advance(leftOfDashString.startIndex, colonIndexInt)
      let leftOfColonString = leftOfDashString[leftOfColonRange]
      var leftOfColonInt = Int(leftOfColonString)!
      print(leftOfColonInt)

      //right of colon
      let rightOfColonRange = leftOfDashString.startIndex.advancedBy(colonIndexInt+1)..<leftOfDashString.endIndex.advancedBy(0)
      //let rightOfColonRange = advance(leftOfDashString.startIndex, colonIndexInt+1)..<advance(leftOfDashString.endIndex, 0)
      let rightOfColonString = leftOfDashString[rightOfColonRange]
      var rightOfColonInt = Int(rightOfColonString)!
      print(rightOfColonInt)

      //------------------------------------------

      //right of dash
      let rightOfDashRange = originalString.startIndex.advancedBy(DashIndexInt+2)..<originalString.endIndex.advancedBy(0)
      //let rightOfDashRange = advance(originalString.startIndex, DashIndexInt+2)..<advance(originalString.endIndex, 0)
      let rightOfDashString = originalString[rightOfDashRange]
      print(rightOfDashString)
      let colonIndex2 = rightOfDashString.lowercaseString.characters.indexOf(":")
      let colonIndexString2 = "\(colonIndex2!)"
      var colonIndexInt2 = Int(colonIndexString2)!

      //left of colon
      let leftOfColonRange2 = rightOfDashString.startIndex.advancedBy(0)..<rightOfDashString.startIndex.advancedBy(colonIndexInt2)
      //let leftOfColonRange2 = advance(rightOfDashString.startIndex, 0)..<advance(rightOfDashString.startIndex, colonIndexInt2)
      let leftOfColonString2 = rightOfDashString[leftOfColonRange2]
      var leftOfColonInt2 = Int(leftOfColonString2)!
      print(leftOfColonInt2)

      //right of colon
      let rightOfColonRange2 = rightOfDashString.startIndex.advancedBy(colonIndexInt2+1)..<rightOfDashString.endIndex.advancedBy(0)
      //let rightOfColonRange2 = advance(rightOfDashString.startIndex, colonIndexInt2+1)..<advance(rightOfDashString.endIndex, 0)
      let rightOfColonString2 = rightOfDashString[rightOfColonRange2]
      var rightOfColonInt2 = Int(rightOfColonString2)!
      print(rightOfColonInt2)

      if(leftOfColonInt == 1){
         leftOfColonInt = 13
      }
      if(leftOfColonInt == 2){
         leftOfColonInt = 14
      }
      if(leftOfColonInt == 3){
         leftOfColonInt = 15
      }
      if(leftOfColonInt2 == 1){
         leftOfColonInt2 = 13
      }
      if(leftOfColonInt2 == 2){
         leftOfColonInt2 = 14
      }
      if(leftOfColonInt2 == 3){
         leftOfColonInt2 = 15
      }


      if(day == "M"){
         mondayHours.append(leftOfColonInt)
         mondayHours.append(leftOfColonInt2)
         mondayMinutes.append(rightOfColonInt)
         mondayMinutes.append(rightOfColonInt2)
      }
      else if(day == "T"){
         tuesdayHours.append(leftOfColonInt)
         tuesdayHours.append(leftOfColonInt2)
         tuesdayMinutes.append(rightOfColonInt)
         tuesdayMinutes.append(rightOfColonInt2)
      }
      else if(day == "W"){
         wednesdayHours.append(leftOfColonInt)
         wednesdayHours.append(leftOfColonInt2)
         wednesdayMinutes.append(rightOfColonInt)
         wednesdayMinutes.append(rightOfColonInt2)
      }
      else if(day == "TH"){
         thursdayHours.append(leftOfColonInt)
         thursdayHours.append(leftOfColonInt2)
         thursdayMinutes.append(rightOfColonInt)
         thursdayMinutes.append(rightOfColonInt2)
      }
      else if(day == "F"){
         fridayHours.append(leftOfColonInt)
         fridayHours.append(leftOfColonInt2)
         fridayMinutes.append(rightOfColonInt)
         fridayMinutes.append(rightOfColonInt2)
      }

   }

   func setTableView(day: String){
      if(day == "M"){
         timesArray = ["7:50 - 8:37", "8:42 - 9:29", "9:29 - 10:05",
            "10:10 - 11:02", "11:07 - 11:54", "11:54 - 12:34",
            "12:39 - 1:26", "1:31 - 2:18", "2:23 - 3:10"]
         periodArray = ["1", "2", "T", "3", "4", "L", "5", "6", "7"]

         //setting up times
         for(var i=0; i<timesArray.count; i++){
            print("penis")
            setHoursAndMinutes(day, time: timesArray[i])
         }

         for(var i=0; i<timesArray.count; i=i+2){
            if(hour >= mondayHours[i] && hour <= mondayHours[i+1] && minutes >= mondayMinutes[i] && minutes <= mondayMinutes[i+1]){
               if(i==0){
                  timeBarLabel.text = "Period 1"
               }
               else if(i==1){
                  timeBarLabel.text = "Period 2"

               }
               else if(i==2){
                  timeBarLabel.text = "Tutorial!"

               }
               else if(i==3){
                  timeBarLabel.text = "Period 3"

               }
               else if(i==4){
                  timeBarLabel.text = "Period 4"

               }
               else if(i==5){
                  timeBarLabel.text = "Lunch Time!"

               }
               else if(i==6){
                  timeBarLabel.text = "Period 5"

               }
               else if(i==7){
                  timeBarLabel.text = "Period 6"

               }
               else if(i==8){
                  timeBarLabel.text = "Period 7"

               }
            }
            else{
               print("stuff")
               timeBarLabel.text = "School's Out!"
            }
         }
         /*
         if(hour >= 7 && hour <= 8 && minutes >= 50 && minutes <= 37){
            timeBarLabel.text = "Period 1"
         }
         else if(hour >= 8 && hour <= 9 && minutes >= 42 && minutes <= 29){
            timeBarLabel.text = "Period 2"
         }
         else if(hour >= 9 && hour <= 10 && minutes >= 29 && minutes <= 5){
            timeBarLabel.text = "Tutorial!"
         }
         else if(hour >= 10 && hour <= 11 && minutes >= 10 && minutes <= 2){
            timeBarLabel.text = "Period 3"
         }
         else if(hour >= 11 && hour <= 11 && minutes >= 7 && minutes <= 54){
            timeBarLabel.text = "Period 4"
         }
         else if(hour >= 11 && hour <= 12 && minutes >= 54 && minutes <= 34){
            timeBarLabel.text = "Lunch Time!"
         }
         else if(hour >= 12 && hour <= 1 && minutes >= 39 && minutes <= 26){
            timeBarLabel.text = "Period 5"
         }
         else if(hour >= 13 && hour <= 14 && minutes >= 34 && minutes <= 18){
            timeBarLabel.text = "Period 6"
         }
         else if(hour >= 14 && hour <= 15 && minutes >= 23 && minutes <= 10){
            timeBarLabel.text = "Period 7"
         }
         else if(hour >= 15 && minutes >= 10){
            timeBarLabel.text = "School's Out!"
         }*/
      }
      else if(day == "T"){

         timesArray = ["7:50 - 9:25", "9:25 - 9:35", "9:40 - 11:15",
            "11:15 - 11:55", "12:00 - 1:35", "1:40 - 3:15"]
         periodArray = ["1", "B", "2", "L", "3", "7"]

         //setting up times
         for(var i=0; i<timesArray.count; i++){
            setHoursAndMinutes(day, time: timesArray[i])
         }
         for(var i=0; i<timesArray.count; i=i+2){
            if(hour >= tuesdayHours[i] && hour <= tuesdayHours[i+1] && minutes >= tuesdayMinutes[i] && minutes <= tuesdayMinutes[i+1]){
               if(i==0){
                  timeBarLabel.text = "Period 1"
               }
               else if(i==1){
                  timeBarLabel.text = "Break!"

               }
               else if(i==2){
                  timeBarLabel.text = "Period 2"

               }
               else if(i==3){
                  timeBarLabel.text = "Lunch!"

               }
               else if(i==4){
                  timeBarLabel.text = "Period 3"

               }
               else if(i==5){
                  timeBarLabel.text = "Period 7"

               }
            }
            else{
               print("stuff")
               timeBarLabel.text = "School's Out!"
            }
         }


         /*
         if(hour >= 7 && hour <= 9 && minutes >= 50 && minutes <= 25){
            timeBarLabel.text = "Period 1"
         }
         else if(hour >= 9 && hour <= 9 && minutes >= 25 && minutes <= 35){
            timeBarLabel.text = "Break!"
         }
         else if(hour >= 9 && hour <= 11 && minutes >= 40 && minutes <= 15){
            timeBarLabel.text = "Period 2"
         }
         else if(hour >= 11 && hour <= 11 && minutes >= 15 && minutes <= 55){
            timeBarLabel.text = "Lunch!"
         }
         else if(hour >= 12 && hour <= 1 && minutes >= 0 && minutes <= 35){
            timeBarLabel.text = "Period 3"
         }
         else if(hour >= 1 && hour <= 3 && minutes >= 40 && minutes <= 15){
            timeBarLabel.text = "Period 7"
         }
         else if(hour >= 15 && minutes >= 15){
            timeBarLabel.text = "School's Out!"
         }*/
      }
      else if(day == "W"){
         timesArray = ["8:50 - 10:25", "10:25 - 10:35", "10:40 - 12:15",
            "12:15 - 12:55", "1:00 - 2:35", "2:40 - 3:10"]
         periodArray = ["4", "B", "5", "L", "6", "T"]

         for(var i=0; i<timesArray.count; i++){
            setHoursAndMinutes(day, time: timesArray[i])
         }
         for(var i=0; i<timesArray.count; i=i+2){
            if(hour >= wednesdayHours[i] && hour <= wednesdayHours[i+1] && minutes >= wednesdayMinutes[i] && minutes <= wednesdayMinutes[i+1]){
               if(i==0){
                  timeBarLabel.text = "Period 4"
               }
               else if(i==1){
                  timeBarLabel.text = "Break!"

               }
               else if(i==2){
                  timeBarLabel.text = "Period 5"

               }
               else if(i==3){
                  timeBarLabel.text = "Lunch!"

               }
               else if(i==4){
                  timeBarLabel.text = "Period 6"

               }
               else if(i==5){
                  timeBarLabel.text = "Tutorial!"

               }
            }
            else{
               print("stuff")
               timeBarLabel.text = "School's Out!"
            }
         }

         /*
         if(hour >= 8 && hour <= 10 && minutes >= 50 && minutes <= 25){
            timeBarLabel.text = "Period 4"
         }
         else if(hour >= 10 && hour <= 10 && minutes >= 25 && minutes <= 35){
            timeBarLabel.text = "Break!"
         }
         else if(hour >= 10 && hour <= 12 && minutes >= 40 && minutes <= 15){
            timeBarLabel.text = "Period 5"
         }
         else if(hour >= 12 && hour <= 12 && minutes >= 15 && minutes <= 55){
            timeBarLabel.text = "Lunch!"
         }
         else if(hour >= 1 && hour <= 2 && minutes >= 0 && minutes <= 35){
            timeBarLabel.text = "Period 6"
         }
         else if(hour >= 2 && hour <= 3 && minutes >= 40 && minutes <= 10){
            timeBarLabel.text = "Tutorial!"
         }
         else if(hour >= 15 && minutes >= 10){
            timeBarLabel.text = "School's Out!"
         }*/

      }
      else if(day == "TH"){
         timesArray = ["7:50 - 9:25", "9:25 - 9:35", "9:40 - 11:15",
            "11:15- 11:55", "12:00 - 1:35", "1:40 - 3:15"]
         periodArray = ["1", "B", "2", "L", "3", "7"]

         for(var i=0; i<timesArray.count; i++){
            setHoursAndMinutes(day, time: timesArray[i])
         }

         for(var i=0; i<timesArray.count; i=i+2){
            if(hour >= thursdayHours[i] && hour <= thursdayHours[i+1] && minutes >= thursdayMinutes[i] && minutes <= thursdayMinutes[i+1]){
               if(i==0){
                  timeBarLabel.text = "Period 1"
               }
               else if(i==1){
                  timeBarLabel.text = "Break!"

               }
               else if(i==2){
                  timeBarLabel.text = "Period 2"

               }
               else if(i==3){
                  timeBarLabel.text = "Lunch!"

               }
               else if(i==4){
                  timeBarLabel.text = "Period 3"

               }
               else if(i==5){
                  timeBarLabel.text = "Period 7"

               }
            }
            else{
               print("stuff")
               timeBarLabel.text = "School's Out!"
            }
         }


      }
      else if(day == "F"){
         timesArray = ["7:50 - 9:25", "9:25 - 10:05", "10:05 - 10:15",
            "10:20 - 12:00", "12:00 - 12:40", "12:45 - 2:20"]
         periodArray = ["4", "T", "B", "5", "L", "6"]

         for(var i=0; i<timesArray.count; i++){
            setHoursAndMinutes(day, time: timesArray[i])
         }
         for(var i=0; i<timesArray.count; i=i+2){
            if(hour >= fridayHours[i] && hour <= fridayHours[i+1] && minutes >= fridayMinutes[i] && minutes <= fridayMinutes[i+1]){
               if(i==0){
                  timeBarLabel.text = "Period 4"
               }
               else if(i==1){
                  timeBarLabel.text = "Tutorial!"

               }
               else if(i==2){
                  timeBarLabel.text = "Break!"

               }
               else if(i==3){
                  timeBarLabel.text = "Period 5"

               }
               else if(i==4){
                  timeBarLabel.text = "Lunch!"

               }
               else if(i==5){
                  timeBarLabel.text = "Period 6"

               }
            }
            else{
               print("stuff")
               timeBarLabel.text = "School's Out!"
            }
         }

         /*
         if(hour >= 7 && hour <= 9 && minutes >= 50 && minutes <= 25){
            timeBarLabel.text = "Period 4"
         }
         else if(hour >= 9 && hour <= 10 && minutes >= 25 && minutes <= 5){
            timeBarLabel.text = "Tutorial!"
         }
         else if(hour >= 10 && hour <= 10 && minutes >= 5 && minutes <= 15){
            timeBarLabel.text = "Break!"
         }
         else if(hour >= 10 && hour <= 12 && minutes >= 20 && minutes <= 0){
            timeBarLabel.text = "Period 5"
         }
         else if(hour >= 12 && hour <= 12 && minutes >= 0 && minutes <= 40){
            timeBarLabel.text = "Lunch!"
         }
         else if(hour >= 12 && hour <= 12 && minutes >= 45 && minutes <= 20){
            timeBarLabel.text = "Period 6"
         }
         else if(hour >= 2 && minutes >= 20){
            timeBarLabel.text = "School's Out!"
         }
         */

      }
      tableView1.reloadData()
   }

   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return timesArray.count
   }

   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PeriodTimesCell
      cell.timesLabel.text = timesArray[indexPath.row]
      cell.timesLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 22)
      cell.timesLabel?.textAlignment = .Center
      cell.periodLabel.text = periodArray[indexPath.row]
      cell.periodLabel.font = UIFont(name: "HelveticaNeue-Light", size: 22)
      cell.periodLabel.textAlignment = .Left

      cell.userInteractionEnabled = false;
      return cell
   }

   func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      let screenHeight = UIScreen.mainScreen().bounds.height
      let heightOfTableView = screenHeight - segmentBar.frame.size.height - timeBar.frame.size.height
         - self.tabBarController!.tabBar.frame.height

      return heightOfTableView / CGFloat(timesArray.count)
   }


   
}
