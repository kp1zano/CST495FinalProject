//
//  Food.swift
//  CalorieCounter
//
//  Created by Yarely on 11/26/16.
//  Copyright © 2016 CSUMB. All rights reserved.

import Foundation

class Food: NSObject, NSCoding {
    
    var name:String;
    var calories:String
    
    init(name: String, calories: String) {
        self.name = name;
        self.calories = calories;
    }
    
    override init(){
        name = "";
        calories = "";
    }
    
    /*
     * Here I added some decode/encode functionality to the class so we can convert to NSData
     * This allows us the ability to save it in NSUserDefaults
     */
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        calories = aDecoder.decodeObjectForKey("calories") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(calories, forKey: "calories")
    }

}
