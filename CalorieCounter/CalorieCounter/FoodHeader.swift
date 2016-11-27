//
//  FoodHeader.swift
//  CalorieCounter
/*
 
 This class controlls the Header in the Food Calorie Table
 */

//  Created by Yarely on 11/26/16.
//  Copyright © 2016 CSUMB. All rights reserved.
//

import UIKit

class FoodHeader: UITableViewHeaderFooterView {
    
    /*
    Initializes the Views for the tableViewHeader
    */
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     Creates a label to display food name header.
     */
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Food Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFontOfSize(14)
        return label
    }()
    
    /*
     Creates a label for food calores header.
     */
    let caloriesLabel: UILabel = {
        let label = UILabel()
        label.text = "Calories"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFontOfSize(14)
        return label
    }()
    
    /*
     Adds all created views to the tableViewHeader, allong with the constraints
     */
    func setupViews() {
        addSubview(nameLabel)
        addSubview(caloriesLabel)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]-4-[v1]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel, "v1": caloriesLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1": caloriesLabel]))
        
    }
    
}

