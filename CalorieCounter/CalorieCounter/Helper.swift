//
//  Helper.swift
//  CalorieCounter
//
//  Created by martin almaraz on 12/9/16.
//  Copyright © 2016 CSUMB. All rights reserved.
//

import Foundation

class Helper {
    
    let username = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
    
    /*
     * Enums to keep food list types in check
     */
    enum TIMES: String {
        case breakfast = "BreakFast Calories"
        case lunch = "Lunch Calories"
        case dinner = "Dinner Calories"
        case snack = "Snack Calories"
    }
    
    /*
     * Used to load a food list given date, and type
     */
    func loadFoodList(date: String,  type: String) -> [Food] {
        var result = [Food]()
        
        if let user = username{
            
            if let loadedDataFoods = NSUserDefaults.standardUserDefaults().dataForKey("foods\(user)\(type)\(date)") {
                
                if let loadedFoods = NSKeyedUnarchiver.unarchiveObjectWithData(loadedDataFoods) as? [Food] {
                    print("Loaded data from userDefaults BREAKFAST \(loadedFoods)")
                    result = loadedFoods
                }
            }
            print("LOADED ATTEMPT: foods\(username!)\(type)\(date)")

            
        }
        print("LOADED ATTEMPT: foods\(type)\(date)")

        
        
        return result
        
    }
    
    /*
     * Used to save a food list similar to how we load
     */
    func saveFoodList(foods: [Food], date: String, type: String) {
        let data : NSData = NSKeyedArchiver.archivedDataWithRootObject(foods)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "foods\(username!)\(type)\(date)")
        
        print("SAVED ATTEMPT: foods\(username!)\(type)\(date)")
    }
    
    /*
     * Quick helper so that we can count the cals in a food list
     */
    func getCalorieSum(foods: [Food]) -> Int {
        var tot = 0
        for item in foods {
            tot += Int(item.calories)!
        }
        return tot
    }
    
}