//
//  RegisterViewController.swift
//  Reportacrime-ios
//
//  Created by Andres Revolledo on 7/6/15.
//  Copyright (c) 2015 Andres Revolledo. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
    @IBAction func registerNewAccount(sender: AnyObject) {
        let name: String = nameTextField.text
        let lastname: String = lastnameTextField.text
        let email: String = emailTextField.text
        let phone: String = phoneTextField.text
        let password: String = passwordTextField.text
        
        let parameters = [
            "user":[
                "name":name,
                "lastname":lastname,
                "email":email,
                "phone":phone,
                "password":password
            ]
        ]
        
        Alamofire.request(.POST, "http://mobdev-aqws3.c9.io/users.json", parameters: parameters, encoding: .JSON)
            .responseJSON{ (request, response, 	JSON, error) in
                //TODO: If registration succesful exit view
                //If registration failed show message
                println(JSON)
                if( error != nil){
                    //If an error happened, you couldnt sign in
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Registration Failed!"
                    alertView.message = "Couldnt Registrate"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
                else {
                    //If it registrated succesfuly, Go back.
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                }
        }
        
    }

}
