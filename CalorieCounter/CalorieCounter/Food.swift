//
//  Food.swift
//  CalorieCounter
//
//  Created by Yarely on 11/26/16.
//  Copyright © 2016 CSUMB. All rights reserved.

class Food{
    
    var name:String;
    var calories:String
    
    init(name: String, calories: String) {
        self.name = name;
        self.calories = calories;
    }
    
    init(){
        name = "";
        calories = "";
    }

}
