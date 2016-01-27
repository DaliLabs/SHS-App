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
    
    @IBOutlet weak var fakeTextField: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var textField: UITextField!
    var datePickerView  : UIDatePicker = UIDatePicker()
    var doneValue : Bool = false
    var textFieldText : String = ""
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if self.textField.text?.characters.count > 0 {
            self.assignment = Assignment(name: self.textField.text!, dueDate : ("Due \(self.datePickerChanged(datePickerView))"))
        }
    }
    
    
    func datePickerChanged(datePicker:UIDatePicker) -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        return strDate
    }

    func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()

        UIView.animateWithDuration(0.01, animations: { () -> Void in
            self.bottomConstraint.constant = keyboardFrame.size.height - 30
        })
    }

    func keyboardWillHide(notification: NSNotification){
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()

        self.bottomConstraint.constant = 30
    }

    @IBAction func textFieldEditing(sender: UITextField) {
        datePickerView = UIDatePicker()

        datePickerView.datePickerMode = UIDatePickerMode.Date

        sender.inputView = datePickerView

        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }


    func datePickerValueChanged(sender:UIDatePicker) {

        let dateFormatter = NSDateFormatter()

        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle

        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle

        fakeTextField.text = dateFormatter.stringFromDate(sender.date)
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        textField.layer.cornerRadius = 10
        doneButton.layer.cornerRadius = 10
        fakeTextField.layer.cornerRadius = 10
        self.bottomConstraint.constant = 30


       

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
