//
//  OrganizeController.swift
//  GameList
//
//  Created by IGI on 30.03.16.
//  Copyright © 2016 IGI2k. All rights reserved.
//

import UIKit
import CoreData

class PlatformCell : UITableViewCell {
    @IBOutlet weak var platformName: UILabel!
    @IBOutlet weak var platformColor: UIView!
}

class OrganizeController : TableDataController {
    
    var dataController: DataController<PlatformMO>!

    override func viewDidLoad() {
        super.viewDidLoad()
        dataController = DataController(entityName: "Platform", delegate: self).fetch("Failed to initialize FetchedResultsController")
    }
    
    func configureCell(cell: PlatformCell, indexPath: NSIndexPath) {
        let platform = dataController.getObject(indexPath)
        cell.platformName.text = platform.name
        cell.platformColor.backgroundColor = platform.color
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("platform", forIndexPath: indexPath) as! PlatformCell
        // Set up the cell
        configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataController.sections!.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = dataController.sections
        let sectionInfo = sections![section]
        return sectionInfo.numberOfObjects
    }
}

