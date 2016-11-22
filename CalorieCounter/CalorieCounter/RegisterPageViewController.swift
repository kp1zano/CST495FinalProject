//
//  RegisterPageViewController.swift
//  CalorieCounter
//
//  Created by Karina Pizano on 11/22/16.
//  Copyright © 2016 CSUMB. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTexField: UITextField!
    @IBOutlet weak var userRepeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(sender: AnyObject) {
        
        /*
         * Get users data and store it.
         */
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTexField.text;
        let userRepeatedPassword = userRepeatPasswordTextField.text;
        
        /*
         * Check for empty fields.
         */
        if(userEmail!.isEmpty || userPassword!.isEmpty || userRepeatedPassword!.isEmpty){
            /*
             * Send an alert message.
             */
            displayAlertMessage("All fields are required");
            return;
        }
        
        /*
         * Check if the passwords match.
         */
        print(userRepeatedPassword);
        print(userPassword);
        print(userEmail);
        if(userPassword! != userRepeatedPassword!){
            /*
             * Send alert message;
             */
            displayAlertMessage("Passwords do not match");
            return;
        }
        
        /*
         * Store data locally.
         */
        
        NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail");
        NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword");
        NSUserDefaults.standardUserDefaults().synchronize();
        
        /*
         * Display confirmation alert.
         */
        let myAlert = UIAlertController(title: "Alert", message: "Profile Successfully Created", preferredStyle: UIAlertControllerStyle.Alert);
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){
            action in self.dismissViewControllerAnimated(true, completion: nil);
            }
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated: true, completion: nil);
        
    }
    
    
    func displayAlertMessage(userMessage:String){
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil);
        
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated: true, completion: nil);
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
