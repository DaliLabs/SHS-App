//
//  BellTabVC.swift
//  Pat'sshsapp
//
//  Created by Patrick Li on 10/11/15.
//


import UIKit

class BellTabVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var segmentBarDays: UISegmentedControl!
    @IBOutlet weak var timeBar: UILabel!
    @IBOutlet weak var timeBarLabel: UILabel!
    @IBOutlet weak var segmentBar: UILabel!
    @IBOutlet weak var tableView1: UITableView!
    
    var cell: PeriodTimesCell!
    var timesArray: [String]! = ["7:50 - 8:37", "8:42 - 9:29", "9:29 - 10:05",
        "10:10 - 11:02", "11:07 - 11:54", "11:54 - 12:34",
        "12:39 - 1:26", "1:31 - 2:18", "2:23 - 3:10"]
    var actualTimes: [String]! = ["7:50 - 8:37", "8:42 - 9:29", "9:29 - 10:05",
        "10:10 - 11:02", "11:07 - 11:54", "11:54 - 12:34",
        "12:39 - 1:26", "1:31 - 2:18", "2:23 - 3:10"]
    var onMondayTab = false
    var periodArray: [String]! = []
    var currTime = 0
    var currDate = 0
    var hour = 0
    var tempHour = 0
    var amOrPm = ""
    var minutes = 0
    var totalCurrMinutes = 0
    var second = 0
    var date = NSDate()
    var calendar = NSCalendar.currentCalendar()
    var currPeriod = 20
    var startMin = 0
    var endMin = 0
    var currTableView = 2
    var dayOfWeek = 0
    
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
    
    var mondayMintuesTotal : [Int] = []
    var tuesdayMinutesTotal : [Int] = []
    var wednesdayMinutesTotal : [Int] = []
    var thursdayMinutesTotal : [Int] = []
    var fridayMinutesTotal : [Int] = []
    
    var counter: Float = 0
    
    
    
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
        var month = components.month
        var year = components.year
        var day = components.day
        
        let currDate = "\(year)-\(month)-\(day)"
        dayOfWeek = getDayOfWeek(currDate)
        currTableView = dayOfWeek
        if(dayOfWeek == 2){
            segmentBarDays.selectedSegmentIndex = 0
            //setting up times
            actualTimes = ["7:50 - 8:37", "8:42 - 9:29", "9:29 - 10:05",
                "10:10 - 11:02", "11:07 - 11:54", "11:54 - 12:34",
                "12:39 - 1:26", "1:31 - 2:18", "2:23 - 3:10"]
            for(var i=0; i<actualTimes.count; i++){
                setHoursAndMinutes("M", time: actualTimes[i])
            }
            setTableView("M")
        }
        else if(dayOfWeek == 3){
            segmentBarDays.selectedSegmentIndex = 1
            actualTimes = ["7:50 - 9:25", "9:25 - 9:35", "9:40 - 11:15",
                "11:15 - 11:55", "12:00 - 1:35", "1:40 - 3:15"]
            for(var i=0; i<actualTimes.count; i++){
                setHoursAndMinutes("T", time: actualTimes[i])
            }
            setTableView("T")
            
        }
        else if(dayOfWeek == 4){
            segmentBarDays.selectedSegmentIndex = 2
            actualTimes = ["8:50 - 10:25", "10:25 - 10:35", "10:40 - 12:15",
                "12:15 - 12:55", "1:00 - 2:35", "2:40 - 3:10"]
            
            for(var i=0; i<actualTimes.count; i++){
                setHoursAndMinutes("W", time: actualTimes[i])
            }
            setTableView("W")
            
        }
        else if(dayOfWeek == 5){
            segmentBarDays.selectedSegmentIndex = 3
            actualTimes = ["7:50 - 9:25", "9:25 - 9:35", "9:40 - 11:15",
                "11:15 - 11:55", "12:00 - 1:35", "1:40 - 3:15"]
            for(var i=0; i<actualTimes.count; i++){
                setHoursAndMinutes("TH", time: actualTimes[i])
            }
            setTableView("TH")
        }
        else if(dayOfWeek == 6){
            segmentBarDays.selectedSegmentIndex = 4
            actualTimes = ["7:50 - 9:25", "9:25 - 10:05", "10:05 - 10:15",
                "10:20 - 12:00", "12:00 - 12:40", "12:45 - 2:20"]
            for(var i=0; i<actualTimes.count; i++){
                setHoursAndMinutes("F", time: actualTimes[i])
            }
            
            setTableView("F")
        }
        else {
            segmentBarDays.selectedSegmentIndex = 0
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
    }
    
    func scheduledTimerWithTimeInterval(){
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func timeLeft(startMin: Int, endMin: Int) -> Float{
        let totalTime = endMin - startMin
        let currMinIntoPeriod = totalCurrMinutes - startMin
        let fraction: Float = Float(currMinIntoPeriod) / Float(totalTime)
        
        return fraction
    }
    func update() {
        date = NSDate()
        calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.Year.union(NSCalendarUnit.Minute)
            .union(NSCalendarUnit.Hour).union(NSCalendarUnit.Month).union(NSCalendarUnit.Day).union(NSCalendarUnit.Second).union(NSCalendarUnit.Weekday), fromDate: date)
        second = components.second
        hour = components.hour
        minutes = components.minute
        totalCurrMinutes = hour*60 + minutes
        
        var timeLeftInPeriod: Int
        if(components.weekday == 2){
            for(var i=0; i<actualTimes.count*2; i=i+2){
                if(totalCurrMinutes >= mondayMintuesTotal[i] && totalCurrMinutes < mondayMintuesTotal[i+1]){
                    if(i<=1){
                        timeLeftInPeriod = mondayMintuesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 0
                        startMin = mondayMintuesTotal[i]
                        endMin = mondayMintuesTotal[i+1]
                    }
                    else if(i<=3){
                        timeLeftInPeriod = mondayMintuesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 1
                        startMin = mondayMintuesTotal[i]
                        endMin = mondayMintuesTotal[i+1]
                    }
                    else if(i<=5){
                        timeLeftInPeriod = mondayMintuesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 2
                        startMin = mondayMintuesTotal[i]
                        endMin = mondayMintuesTotal[i+1]
                    }
                    else if(i<=7){
                        timeLeftInPeriod = mondayMintuesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 3
                        startMin = mondayMintuesTotal[i]
                        endMin = mondayMintuesTotal[i+1]
                    }
                    else if(i<=9){
                        timeLeftInPeriod = mondayMintuesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 4
                        startMin = mondayMintuesTotal[i]
                        endMin = mondayMintuesTotal[i+1]
                    }
                    else if(i<=11){
                        timeLeftInPeriod = mondayMintuesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 5
                        startMin = mondayMintuesTotal[i]
                        endMin = mondayMintuesTotal[i+1]
                    }
                    else if(i<=13){
                        timeLeftInPeriod = mondayMintuesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 6
                        startMin = mondayMintuesTotal[i]
                        endMin = mondayMintuesTotal[i+1]
                    }
                    else if(i<=15){
                        timeLeftInPeriod = mondayMintuesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 7
                        startMin = mondayMintuesTotal[i]
                        endMin = mondayMintuesTotal[i+1]
                    }
                    else if(i<=17){
                        timeLeftInPeriod = mondayMintuesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 8
                        startMin = mondayMintuesTotal[i]
                        endMin = mondayMintuesTotal[i+1]
                    }
                    else if (totalCurrMinutes >= mondayMintuesTotal[0] && totalCurrMinutes < mondayMintuesTotal[mondayMintuesTotal.count-1]){
                        timeBarLabel.text = "Passing!"
                    }
                    else{
                        timeBarLabel.text = "School's Out!"
                    }
                }
                    
                else if (totalCurrMinutes < mondayMintuesTotal[0] || totalCurrMinutes >= mondayMintuesTotal[mondayMintuesTotal.count-1]){
                    timeBarLabel.text = "School's Out!"
                }
            }
            
        }
        else if(components.weekday == 3){
            
            for(var i=0; i<actualTimes.count*2; i=i+2){
                print(i)
                if(totalCurrMinutes >= tuesdayMinutesTotal[i] && totalCurrMinutes < tuesdayMinutesTotal[i+1]){
                    if(i<=1){
                        timeLeftInPeriod = tuesdayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 0
                        startMin = tuesdayMinutesTotal[i]
                        endMin = tuesdayMinutesTotal[i+1]
                    }
                    else if(i<=3){
                        timeLeftInPeriod = tuesdayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 1
                        startMin = tuesdayMinutesTotal[i]
                        endMin = tuesdayMinutesTotal[i+1]
                    }
                    else if(i<=5){
                        timeLeftInPeriod = tuesdayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 2
                        startMin = tuesdayMinutesTotal[i]
                        endMin = tuesdayMinutesTotal[i+1]
                    }
                    else if(i<=7){
                        timeLeftInPeriod = tuesdayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 3
                        startMin = tuesdayMinutesTotal[i]
                        endMin = tuesdayMinutesTotal[i+1]
                    }
                    else if(i<=9){
                        timeLeftInPeriod = tuesdayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 4
                        startMin = tuesdayMinutesTotal[i]
                        endMin = tuesdayMinutesTotal[i+1]
                    }
                    else if(i<=11){
                        timeLeftInPeriod = tuesdayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 5
                        startMin = tuesdayMinutesTotal[i]
                        endMin = tuesdayMinutesTotal[i+1]
                    }
                    else if (totalCurrMinutes >= tuesdayMinutesTotal[0] && totalCurrMinutes < tuesdayMinutesTotal[tuesdayMinutesTotal.count-1]){
                        timeBarLabel.text = "Passing!"
                    }
                    else{
                        timeBarLabel.text = "School's Out!"
                    }
                }
                    
                else if (totalCurrMinutes < tuesdayMinutesTotal[0] || totalCurrMinutes >= tuesdayMinutesTotal[tuesdayMinutesTotal.count-1]){
                    timeBarLabel.text = "School's Out!"
                }
            }
            
        }
        else if(components.weekday == 4){
            
            for(var i=0; i<actualTimes.count*2; i=i+2){
                if(totalCurrMinutes >= wednesdayMinutesTotal[i] && totalCurrMinutes < wednesdayMinutesTotal[i+1]){
                    if(i<=1){
                        timeLeftInPeriod = wednesdayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 0
                        startMin = wednesdayMinutesTotal[i]
                        endMin = wednesdayMinutesTotal[i+1]
                    }
                    else if(i<=3){
                        timeLeftInPeriod = wednesdayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 1
                        startMin = wednesdayMinutesTotal[i]
                        endMin = wednesdayMinutesTotal[i+1]
                        
                    }
                    else if(i<=5){
                        timeLeftInPeriod = wednesdayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 2
                        startMin = wednesdayMinutesTotal[i]
                        endMin = wednesdayMinutesTotal[i+1]
                        
                    }
                    else if(i<=7){
                        timeLeftInPeriod = wednesdayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 3
                        startMin = wednesdayMinutesTotal[i]
                        endMin = wednesdayMinutesTotal[i+1]
                        
                    }
                    else if(i<=9){
                        timeLeftInPeriod = wednesdayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 4
                        startMin = wednesdayMinutesTotal[i]
                        endMin = wednesdayMinutesTotal[i+1]
                        
                    }
                    else if(i<=11){
                        timeLeftInPeriod = wednesdayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 5
                        startMin = wednesdayMinutesTotal[i]
                        endMin = wednesdayMinutesTotal[i+1]
                        
                    }
                    else if (totalCurrMinutes >= wednesdayMinutesTotal[0] && totalCurrMinutes < wednesdayMinutesTotal[wednesdayMinutesTotal.count-1]){
                        timeBarLabel.text = "Passing!"
                    }
                    else{
                        timeBarLabel.text = "School's Out!"
                        
                    }
                    
                }
                    
                else if (totalCurrMinutes < wednesdayMinutesTotal[0] || totalCurrMinutes >= wednesdayMinutesTotal[wednesdayMinutesTotal.count-1]){
                    timeBarLabel.text = "School's Out!"
                }
            }
        }
        else if(components.weekday == 5){
            if(currTableView == dayOfWeek){
                for(var i=0; i<actualTimes.count*2; i=i+2){
                    if(totalCurrMinutes >= thursdayMinutesTotal[i] && totalCurrMinutes < thursdayMinutesTotal[i+1]){
                        if(i<=1){
                            timeLeftInPeriod = thursdayMinutesTotal[i+1] - totalCurrMinutes
                            timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                            currPeriod = 0
                            startMin = thursdayMinutesTotal[i]
                            endMin = thursdayMinutesTotal[i+1]
                        }
                        else if(i<=3){
                            timeLeftInPeriod = thursdayMinutesTotal[i+1] - totalCurrMinutes
                            timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                            currPeriod = 1
                            startMin = thursdayMinutesTotal[i]
                            endMin = thursdayMinutesTotal[i+1]
                        }
                        else if(i<=5){
                            timeLeftInPeriod = thursdayMinutesTotal[i+1] - totalCurrMinutes
                            timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                            currPeriod = 2
                            startMin = thursdayMinutesTotal[i]
                            endMin = thursdayMinutesTotal[i+1]
                        }
                        else if(i<=7){
                            timeLeftInPeriod = thursdayMinutesTotal[i+1] - totalCurrMinutes
                            timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                            currPeriod = 3
                            startMin = thursdayMinutesTotal[i]
                            endMin = thursdayMinutesTotal[i+1]
                        }
                        else if(i<=9){
                            timeLeftInPeriod = thursdayMinutesTotal[i+1] - totalCurrMinutes
                            timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                            currPeriod = 4
                            startMin = thursdayMinutesTotal[i]
                            endMin = thursdayMinutesTotal[i+1]
                        }
                        else if(i<=11){
                            timeLeftInPeriod = thursdayMinutesTotal[i+1] - totalCurrMinutes
                            timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                            currPeriod = 5
                            startMin = thursdayMinutesTotal[i]
                            endMin = thursdayMinutesTotal[i+1]
                        }
                        else if (totalCurrMinutes >= thursdayMinutesTotal[0] && totalCurrMinutes < thursdayMinutesTotal[thursdayMinutesTotal.count-1]){
                            timeBarLabel.text = "Passing!"
                        }
                    }
                        
                    else if (totalCurrMinutes < thursdayMinutesTotal[0] || totalCurrMinutes >= thursdayMinutesTotal[thursdayMinutesTotal.count-1]){
                        timeBarLabel.text = "School's Out!"
                    }
                }
            }
            
        }
        else if(components.weekday == 6){
            for(var i=0; i<actualTimes.count*2; i=i+2){
                if(totalCurrMinutes >= fridayMinutesTotal[i] && totalCurrMinutes <= fridayMinutesTotal[i+1]){
                    if(i<=1){
                        timeLeftInPeriod = fridayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 0
                        startMin = fridayMinutesTotal[i]
                        endMin = fridayMinutesTotal[i+1]
                        
                    }
                    else if(i<=3){
                        timeLeftInPeriod = fridayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 1
                        startMin = fridayMinutesTotal[i]
                        endMin = fridayMinutesTotal[i+1]
                    }
                    else if(i<=5){
                        timeLeftInPeriod = fridayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 2
                        startMin = fridayMinutesTotal[i]
                        endMin = fridayMinutesTotal[i+1]
                    }
                    else if(i<=7){
                        timeLeftInPeriod = fridayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 3
                        startMin = fridayMinutesTotal[i]
                        endMin = fridayMinutesTotal[i+1]
                    }
                    else if(i<=9){
                        timeLeftInPeriod = fridayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 4
                        startMin = fridayMinutesTotal[i]
                        endMin = fridayMinutesTotal[i+1]
                    }
                    else if(i<=11){
                        timeLeftInPeriod = fridayMinutesTotal[i+1] - totalCurrMinutes
                        timeBarLabel.text = String(timeLeftInPeriod) + " minutes remaining"
                        currPeriod = 5
                        startMin = fridayMinutesTotal[i]
                        endMin = fridayMinutesTotal[i+1]
                    }
                    else if (totalCurrMinutes >= fridayMinutesTotal[0] && totalCurrMinutes < fridayMinutesTotal[fridayMinutesTotal.count-1]){
                        timeBarLabel.text = "Passing!"
                    }
                    else{
                        timeBarLabel.text = "School's Out!"
                    }
                }
                else if (totalCurrMinutes < fridayMinutesTotal[0] || totalCurrMinutes >= fridayMinutesTotal[fridayMinutesTotal.count-1]){
                    timeBarLabel.text = "School's Out!"
                }
            }
        }
        else{
            timeBarLabel.text = "School's Out!"
        }
        
        tableView1.reloadData()
        
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
            currTableView = 2
        case 1:
            setTableView("T")
            currTableView = 3
        case 2:
            setTableView("W")
            currTableView = 4
        case 3:
            setTableView("TH")
            currTableView = 5
        case 4:
            setTableView("F")
            currTableView = 6
            
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
        
        let colonIndex = leftOfDashString.lowercaseString.characters.indexOf(":")
        let colonIndexString = "\(colonIndex!)"
        let colonIndexInt = Int(colonIndexString)!
        
        //left of colon
        let leftOfColonRange = leftOfDashString.startIndex.advancedBy(0)..<leftOfDashString.startIndex.advancedBy(colonIndexInt)
        //let leftOfColonRange = advance(leftOfDashString.startIndex, 0)..<advance(leftOfDashString.startIndex, colonIndexInt)
        let leftOfColonString = leftOfDashString[leftOfColonRange]
        var leftOfColonInt = Int(leftOfColonString)!
        
        //right of colon
        let rightOfColonRange = leftOfDashString.startIndex.advancedBy(colonIndexInt+1)..<leftOfDashString.endIndex.advancedBy(0)
        //let rightOfColonRange = advance(leftOfDashString.startIndex, colonIndexInt+1)..<advance(leftOfDashString.endIndex, 0)
        let rightOfColonString = leftOfDashString[rightOfColonRange]
        var rightOfColonInt = Int(rightOfColonString)!
        
        //------------------------------------------
        
        //right of dash
        let rightOfDashRange = originalString.startIndex.advancedBy(DashIndexInt+2)..<originalString.endIndex.advancedBy(0)
        //let rightOfDashRange = advance(originalString.startIndex, DashIndexInt+2)..<advance(originalString.endIndex, 0)
        let rightOfDashString = originalString[rightOfDashRange]
        let colonIndex2 = rightOfDashString.lowercaseString.characters.indexOf(":")
        let colonIndexString2 = "\(colonIndex2!)"
        var colonIndexInt2 = Int(colonIndexString2)!
        
        //left of colon
        let leftOfColonRange2 = rightOfDashString.startIndex.advancedBy(0)..<rightOfDashString.startIndex.advancedBy(colonIndexInt2)
        //let leftOfColonRange2 = advance(rightOfDashString.startIndex, 0)..<advance(rightOfDashString.startIndex, colonIndexInt2)
        let leftOfColonString2 = rightOfDashString[leftOfColonRange2]
        var leftOfColonInt2 = Int(leftOfColonString2)!
        
        //right of colon
        let rightOfColonRange2 = rightOfDashString.startIndex.advancedBy(colonIndexInt2+1)..<rightOfDashString.endIndex.advancedBy(0)
        //let rightOfColonRange2 = advance(rightOfDashString.startIndex, colonIndexInt2+1)..<advance(rightOfDashString.endIndex, 0)
        let rightOfColonString2 = rightOfDashString[rightOfColonRange2]
        var rightOfColonInt2 = Int(rightOfColonString2)!
        
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
            mondayMintuesTotal.append(leftOfColonInt*60 + rightOfColonInt)
            mondayMintuesTotal.append(leftOfColonInt2*60 + rightOfColonInt2)
        }
        else if(day == "T"){
            tuesdayMinutesTotal.append(leftOfColonInt*60 + rightOfColonInt)
            tuesdayMinutesTotal.append(leftOfColonInt2*60 + rightOfColonInt2)
        }
        else if(day == "W"){
            wednesdayMinutesTotal.append(leftOfColonInt*60 + rightOfColonInt)
            wednesdayMinutesTotal.append(leftOfColonInt2*60 + rightOfColonInt2)
        }
        else if(day == "TH"){
            thursdayMinutesTotal.append(leftOfColonInt*60 + rightOfColonInt)
            thursdayMinutesTotal.append(leftOfColonInt2*60 + rightOfColonInt2)
        }
        else if(day == "F"){
            fridayMinutesTotal.append(leftOfColonInt*60 + rightOfColonInt)
            fridayMinutesTotal.append(leftOfColonInt2*60 + rightOfColonInt2)
        }
    }
    func setTableView(day: String){
        if(day == "M"){
            timesArray = ["7:50 - 8:37", "8:42 - 9:29", "9:29 - 10:05",
                "10:10 - 11:02", "11:07 - 11:54", "11:54 - 12:34",
                "12:39 - 1:26", "1:31 - 2:18", "2:23 - 3:10"]
            periodArray = ["1", "2", "T", "3", "4", "L", "5", "6", "7"]
        }
        else if(day == "T"){
            timesArray = ["7:50 - 9:25", "9:25 - 9:35", "9:40 - 11:15",
                "11:15 - 11:55", "12:00 - 1:35", "1:40 - 3:15"]
            periodArray = ["1", "B", "2", "L", "3", "7"]
            //setting up times
            for(var i=0; i<timesArray.count; i++){
                setHoursAndMinutes(day, time: timesArray[i])
            }
        }
        else if(day == "W"){
            timesArray = ["8:50 - 10:25", "10:25 - 10:35", "10:40 - 12:15",
                "12:15 - 12:55", "1:00 - 2:35", "2:40 - 3:10"]
            periodArray = ["4", "B", "5", "L", "6", "T"]
            
            for(var i=0; i<timesArray.count; i++){
                setHoursAndMinutes(day, time: timesArray[i])
            }
        }
        else if(day == "TH"){
            timesArray = ["7:50 - 9:25", "9:25 - 9:35", "9:40 - 11:15",
                "11:15 - 11:55", "12:00 - 1:35", "1:40 - 3:15"]
            periodArray = ["1", "B", "2", "L", "3", "7"]
            for(var i=0; i<timesArray.count; i++){
                setHoursAndMinutes(day, time: timesArray[i])
            }
        }
        else if(day == "F"){
            timesArray = ["7:50 - 9:25", "9:25 - 10:05", "10:05 - 10:15",
                "10:20 - 12:00", "12:00 - 12:40", "12:45 - 2:20"]
            onMondayTab = false
            for(var i=0; i<timesArray.count; i++){
                setHoursAndMinutes(day, time: timesArray[i])
            }
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
        
        if(currTableView == dayOfWeek)
        {
            if(indexPath.row == currPeriod)
            {
                cell.showProgressBar()
                cell.progressBar.setProgress(timeLeft(startMin, endMin: endMin), animated: true)
            }
            else
            {
                cell.hideProgressBar()
            }
        }
        else
        {
            cell.hideProgressBar()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let screenHeight = UIScreen.mainScreen().bounds.height
        let heightOfTableView = screenHeight - segmentBar.frame.size.height - timeBar.frame.size.height
            - self.tabBarController!.tabBar.frame.height
        
        return heightOfTableView / CGFloat(timesArray.count)
    }
    
    
    
}