//
//  CalorieInsertTableViewController.swift
//  CalorieCounter
//
//  Created by Yarely on 11/25/16.
//  Copyright © 2016 CSUMB. All rights reserved.
//
import UIKit


class FoodTableViewController: UITableViewController {
    
    var date:String?
    var meal:String?
    var foods = [Food]()
    var username:String?
    
    override func viewDidLoad() {
    
        /**
         * TODO: 
         * FIXME: Replace with Boolean Test.
         */
        super.viewDidLoad()
        if meal != nil{
            self.title = meal! + " Calories"
            debugPrint(navigationItem.title)

        }
        
        /*
         * Here I load the username to use as part of the key for saving the current foods along with the name of the current view
         * This keeps the key uniq to the view and thus we don't get overlap between tables
         */
        
        username = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
        print("TITLE : \(self.title)")
        print("KEY: foods\(username)\(self.title)")
        
        let helper = Helper()
        let date = NSUserDefaults.standardUserDefaults().valueForKey("date") as! String
        
        print("DATE: \(date)")
        print("TITLE: \(self.title!)")
        print("ENUM: \(Helper.TIMES.breakfast.rawValue)")
        print("ENUM: \(Helper.TIMES.lunch.rawValue)")
        print("ENUM: \(Helper.TIMES.dinner.rawValue)")
        print("ENUM: \(Helper.TIMES.snack.rawValue)")
        
        foods = helper.loadFoodList(date, type: self.title!)
        

        /*
         Resigtering classes that will be used for FoodTAbleViewController
         */
        tableView.registerClass(FoodCell.self, forCellReuseIdentifier: "cellId")
        tableView.registerClass(FoodHeader.self, forHeaderFooterViewReuseIdentifier: "headerId")
        tableView.sectionHeaderHeight = 30

        /*
         Setting the items in the navigation ("Done", "Scanner" and "+" button)
         */
        let scannerButton = UIBarButtonItem(title: "📷", style: .Plain, target: self, action: #selector(FoodTableViewController.barcodeScanner))
        let addButton = UIBarButtonItem(title: "+", style: .Plain, target: self, action: #selector(FoodTableViewController.insertFoodName))
        
        /*
         * Adds two buttons to the right.
         */
        navigationItem.rightBarButtonItems = [scannerButton, addButton];
        
        /*
         * Adds a "Done" Button to left.
         */
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(FoodTableViewController.back))

    }
    
    /* 
     * TODO: Create a POPOVER for adding a new item.
     */
    
    /*
     * Opens the Barcode Scanner Controller.
     */
    
    func barcodeScanner(){
        let BSViewController = self.storyboard?.instantiateViewControllerWithIdentifier("BarcodeScannerViewController") as! BarcodeScannerViewController
        navigationController?.pushViewController(BSViewController, animated: true);
    }
    
    
    /*
     * Dismiss controller to return back to home page
     * Also save the current state of the table in NSUserDefaults
     */
    func back() {
        
        let helper = Helper()
        helper.saveFoodList(self.foods, date: NSUserDefaults.standardUserDefaults().valueForKey("date") as! String, type: self.title!)
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    /*
    Add new food name and calories
    Todo: launch a new page to input name and calores or QRcode reader
     */
    func insertFoodName() {
        /*
         * Similar popUp for editing the attributes for adding a new item
         */
        
        let popUp = UIAlertController(title: "Add Item", message: "Name / Calorie count", preferredStyle: .Alert)
        popUp.addTextFieldWithConfigurationHandler({ (textField) -> Void in textField.text = "name" })
        popUp.addTextFieldWithConfigurationHandler({ (textField) -> Void in textField.text = "calories";
        textField.keyboardType = UIKeyboardType.NumberPad})
        
        popUp.addAction(UIAlertAction(title: "Save", style: .Default, handler: { [weak popUp] (action) -> Void in
            let nameField = popUp!.textFields![0] as UITextField
            let calField = popUp!.textFields![1] as UITextField
            
            print("Text field: \(nameField.text)")
            print("Text field: \(calField.text)")
            
            var sd: String = nameFiled.text!
            print(nameField.text.dynamicType)
            
//            print(sd);

            
            self.foods.append(Food(name: nameField.text!, calories: calField.text!));
            let insertionIndexPath = NSIndexPath(forRow: self.foods.count - 1, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([insertionIndexPath], withRowAnimation: .Right)
            }))
        
        popUp.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        
        self.presentViewController(popUp, animated: true, completion: nil)
    }
    
    /*
     Returns the number of cells in the table view
     */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    /*
     Sets the table view with the content from the array
     */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as! FoodCell
        myCell.nameLabel.text = foods[indexPath.row].name
        myCell.caloriesLabel.text = foods[indexPath.row].calories
        myCell.myTableViewController = self
        return myCell
    }
    
    /*
     Adds the new header to the view
     */
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterViewWithIdentifier("headerId")
    }
    
    /**
     * Adds the action pattern to all List Items.
     */
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //NSLog("You selected cell number: \(indexPath.row)!")
        
        /*
         * Title for Alert Pattern.
         */
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        /*
         * Delete option.
         */
        let deleteAction = UIAlertAction(title: "Delete", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            //print("File Deleted");
            self.deleteCell(tableView.cellForRowAtIndexPath(indexPath)!);
        })
        /*
         * Edit option.
         * TODO: Implement Editing.
         */
        
        let name = foods[indexPath.row].name
        let cal = foods[indexPath.row].calories
        
        let editAction = UIAlertAction(title: "Edit", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("File Was Edited");
            
            /*
             * Create popUp that presents two textViews to edit the item selected
             * The preset text is the current data
             */
            
            let popUp = UIAlertController(title: "Edit Item", message: "Edit name and/or calorie count", preferredStyle: .Alert)
            popUp.addTextFieldWithConfigurationHandler({ (textField) -> Void in textField.text = "\(name)" })
            popUp.addTextFieldWithConfigurationHandler({ (textField) -> Void in textField.text = "\(cal)";
                textField.keyboardType = UIKeyboardType.NumberPad })
            
            popUp.addAction(UIAlertAction(title: "Save", style: .Default, handler: { [weak popUp] (action) -> Void in
                let nameField = popUp!.textFields![0] as UITextField
                let calField = popUp!.textFields![1] as UITextField
                
                print("Text field: \(nameField.text)")
                print("Text field: \(calField.text)")
                	
                self.foods[indexPath.row].name = nameField.text!
                self.foods[indexPath.row].calories = calField.text!
                self.tableView.reloadData()
            }))
            
            popUp.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
            
            self.presentViewController(popUp, animated: true, completion: nil)
            
            
        })
        
        /*
         * Cancel option.
         */
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled");
        })
        
        
        /*
         * Add all buttons.
         */
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(editAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    /*
     Deletes cell
     */
    func deleteCell(cell: UITableViewCell) {
        if let deletionIndexPath = tableView.indexPathForCell(cell) {
            foods.removeAtIndex(deletionIndexPath.row)
            tableView.deleteRowsAtIndexPaths([deletionIndexPath], withRowAnimation: .Automatic)
        }
    }
    
}




