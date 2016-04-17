//
//  Items.swift
//  GameList
//
//  Created by IGI on 28.03.16.
//  Copyright © 2016 IGI2k. All rights reserved.
//

import UIKit
import CoreData

protocol EntityInitialSort {
    static var initialSort: [NSSortDescriptor]? { get }
}

class GameMO : NSManagedObject, EntityInitialSort {
    @NSManaged
    var title : String?
    @NSManaged
    var platform : PlatformMO?
    
    static let initialSort: [NSSortDescriptor]? = [ NSSortDescriptor(key: "title", ascending: true) ]
}

class PlatformMO: NSManagedObject, EntityInitialSort {
    @NSManaged
    var name : String?
    @NSManaged
    var color : UIColor?

    static let initialSort: [NSSortDescriptor]? = [ NSSortDescriptor(key: "name", ascending: true) ]
}