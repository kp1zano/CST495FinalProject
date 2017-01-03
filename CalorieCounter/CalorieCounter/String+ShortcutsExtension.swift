//
//  String+.swift
//  CalorieCounter
//
//  Created by Yarely on 12/21/16.
//  Copyright © 2016 CSUMB. All rights reserved.
//

import Foundation

//Extension adds a new feature to verify user input
extension String {

    struct NumberFormatter {
        static let instance = NSNumberFormatter()
    }
    var doubleValue:Double? {
        return NumberFormatter.instance.numberFromString(self)?.doubleValue
    }
    var integerValue:Int? {
        return NumberFormatter.instance.numberFromString(self)?.integerValue
    }
}

