//
//  AddGameController.swift
//  GameList
//
//  Created by IGI on 28.03.16.
//  Copyright © 2016 IGI2k. All rights reserved.
//

import UIKit
import CoreData

class AddGameController : UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, DataControllerDelegate {
    
    @IBOutlet weak var gameTitle: UITextField!
    var gamePlatform: PlatformMO!
    
    var dataController: DataController<PlatformMO>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataController = DataController(entityName: "Platform", delegate: self).fetch("Failed to initialize FetchedResultsController")

        // select default
        //FIXME: check if we have values
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.gamePlatform = dataController.getObject(indexPath)
    }
    
    func createGameItem(){
        
        let game: GameMO = dataController.createNewObject("Game")
        
        // add properties
        game.title = self.gameTitle.text
        game.platform = self.gamePlatform
        
        // save
        dataController.saveContext()
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let sections = dataController.sections {
            return sections[0].numberOfObjects
        }
        return 0
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let indexPath = NSIndexPath(forRow: row, inSection: 0)
        let platform = dataController.getObject(indexPath)
        return platform.name
    }
    
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let indexPath = NSIndexPath(forRow: row, inSection: 0)
        self.gamePlatform = dataController.getObject(indexPath)
    }
    
    @IBAction
    func createGame(sender: AnyObject) {
        createGameItem()
        //TODO: check result
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction
    func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
}