//
//  TableViewController.swift
//  CalorieCounter
//
//  Created by Yarely on 11/22/16.
//  Copyright © 2016 CSUMB. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    var datePickerHidden = true;
    @IBOutlet weak var totalCalories: UILabel!
    @IBOutlet weak var breakCalories: UILabel!
    @IBOutlet weak var lunchCalories: UILabel!
    @IBOutlet weak var dinnerCalories: UILabel!
    @IBOutlet weak var snacksCalories: UILabel!
    

    @IBAction func datePickerValue(sender: UIDatePicker) {
        datePickerChanged()
    }
    /*
     Changes datepicker label
     */
    func datePickerChanged () {
        
       let dateFormatter = NSDateFormatter()
       dateFormatter.dateFormat = "MM/dd/yyyy"
       detailLabel.text = dateFormatter.stringFromDate(datePicker.date)
       //Debugin:
        debugPrint(dateFormatter.stringFromDate(datePicker.date))
        
    }
    
    /*
     View to check if date did load. (Initializer)
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerChanged()
    }
    
    /*
     Select the row at index path, this will trigger the hiding method
     */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            toggleDatepicker()
        }
    }
    /*
     
     */
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if datePickerHidden && indexPath.section == 0 && indexPath.row == 1 {
            return 0
        }
        else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    /*
     
     */
    func toggleDatepicker() {
        
        datePickerHidden = !datePickerHidden
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    @IBAction func logoutButtonAction(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        self.performSegueWithIdentifier("loginView", sender: self);
    }

    override func viewDidAppear(animated: Bool) {
        
        /*
         * Check if the user is LogginIn.
         */
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        
        /*
         * If the User is not Logged in then do not Show Home Page.
         */
        if(!isUserLoggedIn){
            self.performSegueWithIdentifier("loginView", sender: self);
        }
    }
    

}
