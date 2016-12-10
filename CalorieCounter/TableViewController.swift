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
    var mealType:String = "";
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
        
        let dateFormatter = NSDateFormatter();
       dateFormatter.dateFormat = "MM/dd/yyyy";
        detailLabel.text = dateFormatter.stringFromDate(datePicker.date);
       //Debugin:
        debugPrint(dateFormatter.stringFromDate(datePicker.date));
        
    }
    
    /*
     View to check if date did load. (Initializer)
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerChanged()
        self.title = "Home Page"
        loadCounts()
    }
    
    /*
     Select the row at index path, this will trigger the hiding method
     */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            toggleDatepicker();
        }else if indexPath.section == 1{
            switch indexPath.row {
            case 0 :
                //Section 1 (Meals): Breakfast
                mealType = "BreakFast";
                 performSegueWithIdentifier("calorieInsert", sender: self)
            case 1 :
                mealType = "Lunch";
                 performSegueWithIdentifier("calorieInsert", sender: self)
            case 2 :
                mealType = "Dinner";
                 performSegueWithIdentifier("calorieInsert", sender: self)
            case 3 :
                mealType = "Snacks";
                 performSegueWithIdentifier("calorieInsert", sender: self)
            default:
                break
            }
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
     Hide table view
     */
    func toggleDatepicker() {
        
        datePickerHidden = !datePickerHidden
        tableView.beginUpdates()
        tableView.endUpdates()
        loadCounts()
        
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
        
        loadCounts()
    }
    
    /*
     * Load the current cal count of the tables
     * and set them
     * I think this is a bit messy with all the if let..if let... etc + the loops
     * so if anyone knows a cleaner way of doing this, then...
     */
    
    func loadCounts() {
        print("LOADING COUNTS")
        
        let helper = Helper()
        let breakfastTot = helper.getCalorieSum((helper.loadFoodList(String(datePicker.date), type: Helper.TIMES.breakfast.rawValue)))
        let lunchTot = helper.getCalorieSum((helper.loadFoodList(String(datePicker.date), type: Helper.TIMES.lunch.rawValue)))
        let dinnerTot = helper.getCalorieSum((helper.loadFoodList(String(datePicker.date), type: Helper.TIMES.dinner.rawValue)))
        let snackTot = helper.getCalorieSum((helper.loadFoodList(String(datePicker.date), type: Helper.TIMES.snack.rawValue)))
        
        self.breakCalories.text = "\(breakfastTot)"
        self.lunchCalories.text = "\(lunchTot)"
        self.dinnerCalories.text = "\(dinnerTot)"
        self.snacksCalories.text = "\(snackTot)"
        self.totalCalories.text = "\(breakfastTot + lunchTot + dinnerTot + snackTot)"
        
        print("DONE LOADING COUNTS TOT: \(breakfastTot + lunchTot + dinnerTot + snackTot)")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "calorieInsert"){
            debugPrint("before segue")
            NSUserDefaults.standardUserDefaults().setObject(String(self.datePicker.date), forKey: "date")
            let navController = segue.destinationViewController as! UINavigationController;
            let detailController = navController.topViewController as! FoodTableViewController;
            detailController.date = detailLabel.text;
            detailController.meal = mealType;
        }
    }
    

}
