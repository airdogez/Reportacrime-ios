//
//  ViewController.swift
//  Reportacrime-ios
//
//  Created by Andres Revolledo on 6/27/15.
//  Copyright (c) 2015 Andres Revolledo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: AnyObject) {
        //Verify that there is data
        var email:NSString = emailTextField.text
        var password:NSString = passwordTextField.text
        if (email.isEqualToString("") || password.isEqualToString("")){
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Enter your email and password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else {
        let parameters = [
            "user":[
                "email":email,
                "password":password
            ]
        ]
        Alamofire.request(.POST, "http://mobdev-aqws3.c9.io/users/sign_in.json", parameters: parameters, encoding: .JSON)
            .responseJSON { (request, response, json, error) in
                //Get credentials and populate user data
                println(request)
                println(response)
                println(json)
                println(error)
                if( error != nil){
                    //If an error happened, you couldnt sign in
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign in Failed!"
                    alertView.message = "Email/password did not match"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
                else {
                    //Convert to SwiftyJSON and retrieve data
                    var json = JSON(json!)
                    let name: String = json["name"].stringValue
                    let lastname: String = json["lastname"].stringValue
                    let email: String = json["email"].stringValue
                    let token: String = json["authentication_token"].stringValue
                    let id: Int = json["id"].intValue
                    //Create a user and go back to main screen
                    var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    prefs.setObject(name, forKey:"NAME")
                    prefs.setObject(lastname, forKey:"LASTNAME")
                    prefs.setObject(email, forKey:"EMAIL")
                    prefs.setObject(token, forKey:"TOKEN")
                    prefs.setInteger(id, forKey: "ID")
                    prefs.setInteger(1, forKey: "ISLOGGEDIN")
                    prefs.synchronize()
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                }
        }
        }
    }
}



