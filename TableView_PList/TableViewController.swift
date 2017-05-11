//
//  TableViewController.swift
//  TableView_PList
//
//  Created by Duy Bùi on 5/11/17.
//  Copyright © 2017 Duy Bùi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var isColorInverted = true
    var color1 = UIColor(
        red: 0.3,
        green: 0.3,
        blue: 0.0,
        alpha: 1.0)
    let color2 = UIColor(
        white: 0.9,
        alpha: 1.0)
    var pies = [
        "Pizza",
        "Chicken Pot",
        "Shepherd's"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PieCell", for: indexPath)
        let row = indexPath.row
        // Configure the cell...
        
        cell.textLabel?.text = pies[row]
        if isColorInverted{
            cell.backgroundColor = color2
            cell.textLabel?.textColor = color1
        } else {
            cell.backgroundColor = color1
            cell.textLabel?.textColor = color2
        }
        
        return cell
    }
    
    func readPropertyList(){
        var format = PropertyListSerialization.PropertyListFormat.xml // format of the property list
        var plistData: [String:AnyObject] = [:]
        let plistPath: String? = Bundle.main.path(forResource: "data", ofType: "plist")
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        //Mark: - Convert the data to a dictionary and handle error
        do {
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &format) as! [String:AnyObject]
            
            //assign the values in the dictionary to the properties
            isColorInverted = plistData["Inverse Color"] as! Bool
            
            let red = plistData["Red"] as! CGFloat
            let green = plistData["Green"] as! CGFloat
            let blue = plistData["Blue"] as! CGFloat
            color1 = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            
            pies = plistData["Pies"] as! [String]
        }
            //MARK: - Error Condidtion
        catch{
            print("Error reading plist: \(error), format: \(format)")
        }
    } }
