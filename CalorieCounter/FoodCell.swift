//
//  FoodTableViewCell.swift
//  CalorieCounter
//
//  Created by Yarely on 11/25/16.
//  Copyright © 2016 CSUMB. All rights reserved.
//

import UIKit

class FoodCell: UITableViewCell {
    
    var myTableViewController: FoodTableViewController?
    
    /*
     Initializes the Views for the tableViewCell
     */
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
     Creates a label to display food name.
     */
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Item"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFontOfSize(14)
        return label
    }()
    
    /*
     Creates a label to display food calories.
     */
    let caloriesLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFontOfSize(14)
        return label
    }()
    
    
    /*
     Adds all created views to the tableView, allong with the constraints
     */
    func setupViews() {
        addSubview(nameLabel)
        addSubview(caloriesLabel)

        //TODO: Fix the alignment.
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]-235-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel, "v1": caloriesLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": caloriesLabel]))
        
    }
    
}















