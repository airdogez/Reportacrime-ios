//
//  HistoryViewController.swift
//  Reportacrime-ios
//
//  Created by Andres Revolledo on 7/6/15.
//  Copyright (c) 2015 Andres Revolledo. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class HistoryViewController: UIViewController, UITableViewDataSource {

    
    var crimes = [NSManagedObject]()
    
    @IBOutlet weak var historyTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadCrimes()
        
        historyTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crimes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell!
        
        let crime = crimes[indexPath.row]
        cell.textLabel!.text = crime.valueForKey("name") as! String?
        return cell
    }
    
    func loadCrimes() {
        //Get all reports from database and load them on crimes
        //Get user ID stored in preferences to search in URL
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let user_id:Int = prefs.integerForKey("ID")
        
        Alamofire.request(.GET, "http://mobdev-aqws3.c9.io/api/v1/crimes", parameters: ["user_id": user_id])
            .responseJSON{ (request, response, json, error) in
                //Convert all te crimes to SwiftyJSON and store them in crimes
                println(response)
                println(request)
                println(json)
                var json = JSON(json!)
                //The first element is the crime array
                let crimes: JSON = json["crimes"]
                println(crimes)
                //Now retrieve the data from each crime
                for ( key: String, subJson: JSON) in crimes {
                    let name: String = subJson["name"].stringValue
                    let description: String = subJson["description"].stringValue
                    let address: String = subJson["address"].stringValue
                    let status: String = subJson["status"]["name"].stringValue
                    let category: String = subJson["category"]["name"].stringValue
                    let district: String = subJson["district"]["name"].stringValue
                    self.populateCrimes(name, description: description, address: address, status: status, category: category, district: district)
                    println(self.crimes)
                    self.historyTable.reloadData()
                }
        }
    }
    
    func populateCrimes(name: String, description: String, address: String, status: String, category: String, district: String){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate!
        let managedContext = appDelegate.managedObjectContext!
        let entity = NSEntityDescription.entityForName("Crime", inManagedObjectContext: managedContext)
        let crime = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        crime.setValue(name, forKey: "name")
        crime.setValue(description, forKey: "report_description")
        crime.setValue(address, forKey: "address")
        crime.setValue(status, forKey: "status")
        crime.setValue(category, forKey: "category")
        crime.setValue(district, forKey: "district")
        
        self.crimes.append(crime)
    }

}
