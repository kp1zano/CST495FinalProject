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
     Creates a button to remove foods.
     */
    let actionButton: UIButton = {
        let button = UIButton(type: .System)
        button.setTitle("Delete", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /*
     Adds all created views to the tableView, allong with the constraints
     */
    func setupViews() {
        addSubview(nameLabel)
        addSubview(actionButton)
        addSubview(caloriesLabel)
        
        actionButton.addTarget(self, action: #selector(FoodCell.handleAction), forControlEvents: .TouchUpInside)
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]-1-[v1]-1-[v2(80)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel, "v1": caloriesLabel, "v2": actionButton]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": caloriesLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": actionButton]))
        
    }
    
    /*
    Deletes the cell seleted
     */
    func handleAction() {
        myTableViewController?.deleteCell(self)
    }
    
}















