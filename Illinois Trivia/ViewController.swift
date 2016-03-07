//
//  ViewController.swift
//  Illinois Trivia
//
//  Assignment: Mini-app implmenting what we learned this week.
//  We learned about Table Views.  This project uses a Table View
//  to list the counties of Illinois.  Clicking on the county 
//  displays some statistics about county and location on an
//  Illinois map.
//
//  ONLY LAKE AND MCHENRY COUNTIES ARE IMPLEMENTED AT THIS TIME.
//  Need to implement different data structure or plist before
//  adding other counties.  Could eventully include all states too.
//
//  Created by Janet Weber on 3/6/16.
//  Copyright © 2016 Weber Solutions. All rights reserved.
//
// https://grokswift.com/transparent-table-view/

import UIKit

class ViewController: UIViewController,
        UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ILTableView: UITableView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var L1label: UILabel!
    @IBOutlet weak var L2label: UILabel!
    @IBOutlet weak var L3label: UILabel!
    @IBOutlet weak var L4label: UILabel!
    @IBOutlet weak var L5label: UILabel!
    @IBOutlet weak var CountyImage: UIImageView!
    
    private let ILcounties = ["Adams", "Alexander", "Bond", "Boone", "Brown", "Bureau", "Calhoun", "Carroll", "Cass", "Champaign", "Christian", "Clark", "Clay", "Clinton", "Coles", "Cook", "Crawford", "Cumberland", "DeKalb", "DeWitt", "Doublas", "DuPage", "Edgar", "Edwards", "Effingham", "Fayette", "Ford", "Franklin", "Fulton", "Gallatin", "Greene", "Hamilton", "Hancock", "Hardin", "Henderson", "Henry", "Iroquois", "Jackson", "Jasper", "Jefferson", "Jersey", "Jo Daviess", "Johnson", "Kane", "Kankakee", "Kendall", "Knox", "Lake", "LaSalle", "Lawrence", "Lee", "Livingston", "Logan", "Macon", "Macoupin", "Madison", "Marion", "Marshall", "Mason", "Massac", "McDonough", "McHenry", "McLean", "Menard", "Mercer", "Monroe", "Montgomery", "Morgan", "Moultrie", "Ogle", "Peoria", "Perry", "Piatt", "Pike", "Pope", "Pulaski", "Putnam", "Randolph", "Richland", "Rock Island", "Saline", "Sangamon", "Schuyler", "Scott", "Shelby", "St. Clair", "Stark", "Stephenson", "Tazewell", "Union", "Vermillion", "Wabash", "Warren", "Washington", "Wayne", "White", "Whiteside", "Will", "Williamson", "Winnebago", "Woodford"]
    
    let ILcountiesTableIdentifier = "ILcountiesTableIdentifier"
    
    private let myCounties = ["Lake","McHenry"]
    private let lake = ["Waukegan", "Lake Michigan", "1839", "703,462","lake"]
    private let mchenry = ["Woodstock", "Major William McHenry", "1836", "308,760", "mchenry"]

    // *****************************************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Add a background view to the table view
        infoView.hidden = true
        let backgroundImage = UIImage(named: "illinois-seal.png")
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .ScaleAspectFit             // don't allow stretching
        ILTableView.backgroundView = imageView              // display background image
        
        // Tried this but the effect is way too blurred.  Leaving code here for future reference.
        /*let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // *****************************************************************************
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ILcounties.count                             // return number of elements in array
    }
    
    // *   *   *   *   *   *
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // get a cell that's already been used if available.  If not (nil), then create one.
        var cell = tableView.dequeueReusableCellWithIdentifier(ILcountiesTableIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: ILcountiesTableIdentifier)
        }
        
        cell?.textLabel?.text = ILcounties[indexPath.row]        // set table cell text from array
        cell?.textLabel?.font = UIFont .italicSystemFontOfSize(20) // set the font
        return cell!                                             // done.
    }

    // *   *   *   *   *   *
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.85)  // .clearColor()
    }
    
    /*
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return indexPath
    }*/
    
    // *   *   *   *   *   *
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var haveInfo = false
        var imageName : String
        var array : [String]
        let rowValue = ILcounties[indexPath.row]
        
        for (var i=0; i < myCounties.count; i++) {
            if (rowValue == myCounties[i]){
                haveInfo = true

            }
        }
        if (haveInfo) {
            if (rowValue == "Lake") {array = lake}
            else {array = mchenry}
            L1label.text = array[0]
            L2label.text = array[1]
            L3label.text = array[2]
            L4label.text = array[3]
            L5label.text = rowValue + " County"
            imageName = array[4] + "image"
            CountyImage.image = UIImage(named: imageName)
            ILTableView.hidden=true
            infoView.hidden=false
        
        } else {
            //let message = "You selected \(rowValue)"
            let title = "\(rowValue) County - No Info"
            let message = "Try Lake or Mchenry County"
            let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            let action = UIAlertAction(title: "Back to List", style: .Default, handler: nil)
            controller.addAction(action)
            presentViewController(controller, animated: true, completion: nil)
        }
    }

    @IBAction func onButtonPressed(sender: AnyObject) {
        infoView.hidden = true
        ILTableView.hidden = false
        L5label.text = "ILLINOIS COUNTIES"
    }
    

}

