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
        if date != nil{
        
        }
        foods.append(Food(name: "Pizza", calories: "9"));
        foods.append(Food(name: "Pizza", calories: "9"));

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
     Dismiss controller to return back to home page
     */
    func back() {
         self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    /*
    Add new food name and calories
    Todo: launch a new page to input name and calores or QRcode reader
     */
    func insertFoodName() {
        foods.append(Food(name: "Coffee", calories: "18"));
        let insertionIndexPath = NSIndexPath(forRow: foods.count - 1, inSection: 0)
       debugPrint(insertionIndexPath)
        tableView.insertRowsAtIndexPaths([insertionIndexPath], withRowAnimation: .Right)
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
        let editAction = UIAlertAction(title: "Edit", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("File Was Edited");
            
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




