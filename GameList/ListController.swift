//
//  ListController.swift
//  GameList
//
//  Created by IGI on 28.03.16.
//  Copyright © 2016 IGI2k. All rights reserved.
//

import UIKit
import CoreData

class GameCell : UITableViewCell {
    @IBOutlet weak var gamePlatform: UILabel!
    @IBOutlet weak var gameTitle: UILabel!
}

class ListController : TableDataController, UISearchBarDelegate {
    var dataController: DataController<GameMO>!
    let DATA_CACHE_NAME = "rootCache"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataController = DataController(entityName: "Game", delegate: self, cacheName: DATA_CACHE_NAME)
            .fetch("Failed to initialize FetchedResultsController")
        // hide search bar
        //TODO: use searchbar controller and set height from searchbar
        self.tableView.contentOffset = CGPointMake(0.0, 44.0)
    }
    
    func configureCell(cell: GameCell, indexPath: NSIndexPath) {
        let game = dataController.getObject(indexPath)
        cell.gameTitle.text = game.title
        cell.gamePlatform.text = game.platform?.name
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("item", forIndexPath: indexPath) as! GameCell
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
    
    //MARK: Search bar
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        //TODO: on iOS8 clear is fired twice
        dataController.filter.contains("title", value: searchText).fetch("Failed to filter");
        tableView.reloadData()
    }
    
    //MARK: Swipe to delete
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            dataController.deleteObject(indexPath)
            dataController.saveContext()
        }
    }

}

