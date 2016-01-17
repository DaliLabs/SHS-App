//
//  AddAssignmentViewController.swift
//  Planner
//
//  Created by Daniel Bessonov on 11/7/15.
//  Copyright © 2015 Daniel Bessonov. All rights reserved.
//

import UIKit

class AddAssignmentViewController: UIViewController, UIPickerViewDelegate {
    
    var assignment: Assignment = Assignment(name: "", dueDate: "")
    
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var textField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    var doneValue : Bool = false
    var textFieldText : String = ""
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if self.textField.text?.characters.count > 0 {
            self.assignment = Assignment(name: self.textField.text!, dueDate : self.datePickerChanged(dueDatePicker))
        }
    }
    
    
    func datePickerChanged(datePicker:UIDatePicker) -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        return strDate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
