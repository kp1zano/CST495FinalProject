//
//  LoginViewController.swift
//  CalorieCounter
//
//  Created by Karina Pizano on 11/22/16.
//  Copyright © 2016 CSUMB. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAlertMessage(userMessage:String){
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "Alert", style: UIAlertActionStyle.Default, handler: nil);
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated: true, completion: nil);
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        /*
         * Grab the information that the user inserted.
         */
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        
        /*
         * Make sure none of the fields are empty.
         */
        if(userEmail!.isEmpty || userPassword!.isEmpty){
            displayAlertMessage("All fields are required");
        }
        
        /*
         * Read from hte local DB for the inputs.
         */
        let userEmailStored = NSUserDefaults.standardUserDefaults().stringForKey("userEmail");
        let userPasswordStored = NSUserDefaults.standardUserDefaults().stringForKey("userPassword");
        
        /*
         * Make sure stored credentials match input.
         */
        if(userEmailStored == userEmail){
            
            if(userPasswordStored == userPassword){
                // Login Successfull.
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn");
                NSUserDefaults.standardUserDefaults().synchronize();
                self.dismissViewControllerAnimated(true, completion: nil);
                return;
            }
            displayAlertMessage("Incorrect Password or Email");
        }
        displayAlertMessage("No email found");
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
