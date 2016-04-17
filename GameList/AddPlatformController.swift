//
//  AddPlatformController.swift
//  GameList
//
//  Created by IGI on 30.03.16.
//  Copyright © 2016 IGI2k. All rights reserved.
//

import UIKit
import CoreData

class AddPlatformController : UITableViewController {
    
    @IBOutlet weak var colorResult: UIView!
    @IBOutlet weak var colorSlider: UISlider!
    @IBOutlet weak var platformName: UITextField!
    
    let colorArray = [ 0x000000, 0x262626, 0x4d4d4d, 0x666666, 0x808080, 0x990000, 0xcc0000, 0xfe0000, 0xff5757, 0xffabab, 0xffabab, 0xffa757, 0xff7900, 0xcc6100, 0x994900, 0x996f00, 0xcc9400, 0xffb900, 0xffd157, 0xffe8ab, 0xfff4ab, 0xffe957, 0xffde00, 0xccb200, 0x998500, 0x979900, 0xcacc00, 0xfcff00, 0xfdff57, 0xfeffab, 0xf0ffab, 0xe1ff57, 0xd2ff00, 0xa8cc00, 0x7e9900, 0x038001, 0x04a101, 0x05c001, 0x44bf41, 0x81bf80, 0x81c0b8, 0x41c0af, 0x00c0a7, 0x00a18c, 0x00806f, 0x040099, 0x0500cc, 0x0600ff, 0x5b57ff, 0xadabff, 0xd8abff, 0xb157ff, 0x6700bf, 0x5700a1, 0x450080, 0x630080, 0x7d00a1, 0x9500c0, 0xa341bf, 0xb180bf, 0xbf80b2, 0xbf41a6, 0xbf0199, 0xa10181, 0x800166, 0x999999, 0xb3b3b3, 0xcccccc, 0xe6e6e6, 0xffffff]
    
    @IBAction
    func sliderChanged(sender: AnyObject) {
        changeColor()
    }
    
    func changeColor() {
        colorResult.backgroundColor = uiColorFromHex(colorArray[Int(colorSlider.value)])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeColor()
    }
    
    func uiColorFromHex(rgbValue: Int) -> UIColor {
        
        let red =   CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(rgbValue & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func createPlatformItem(){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        let platform = NSEntityDescription.insertNewObjectForEntityForName("Platform", inManagedObjectContext: managedObjectContext) as! PlatformMO
        
        // add properties
        platform.name = platformName.text
        platform.color = colorResult.backgroundColor
        
        // save
        appDelegate.saveContext()
    }
    
    @IBAction
    func createPlatform(sender: AnyObject) {
        createPlatformItem()
        //TODO: check result
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction
    func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
}
