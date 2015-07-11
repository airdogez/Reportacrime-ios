//
//  MenuViewController.swift
//  Reportacrime-ios
//
//  Created by Andres Revolledo on 7/6/15.
//  Copyright (c) 2015 Andres Revolledo. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class MenuViewController: UIViewController {
    
    var name = String()
    var lastname = String()
    var email = String()
    var token = String()
    var id = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegueWithIdentifier("goto_login", sender: self)
        } else {
            
            name = prefs.stringForKey("NAME")!
            lastname = prefs.stringForKey("LASTNAME")!
            email = prefs.stringForKey("EMAIL")!
            token = prefs.stringForKey("TOKEN")!
            id = prefs.integerForKey("ID") as Int
            
        }
        
    }
    @IBAction func goToCrimeReportHistory(sender: AnyObject) {
        
    }
    
    @IBAction func logout(sender: AnyObject) {
        var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        prefs.setInteger(0, forKey: "ISLOGGEDIN")
        prefs.synchronize()
        self.performSegueWithIdentifier("goto_login", sender: self)
    }
	
}
