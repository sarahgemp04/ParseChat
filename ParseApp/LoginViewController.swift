//
//  LoginViewController.swift
//  ParseApp
//
//  Created by Sarah Gemperle on 4/3/19.
//  Copyright © 2019 Sarah Gemperle. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
    }
    
    @IBAction func didClickSignUp(_ sender: Any) {
        // initialize a user object
        let newUser = PFUser()
        
        let username = userNameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if(username.isEmpty || password.isEmpty) {
            // create the alert for notification of error.
            let alert = UIAlertController(title: "Error Signing Up", message: "Please fill out both fields.", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        newUser.username = userNameTextField.text
        newUser.password = passwordTextField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
         
            if let error = error {
                // create the alert for notification of error.
                let alert = UIAlertController(title: "Error Signing Up", message: "Username already exists.", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func didClickLogin(_ sender: Any) {
        
        let username = userNameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if(username.isEmpty || password.isEmpty) {
            // create the alert for notification of error.
            let alert = UIAlertController(title: "Error Signing Up", message: "Please fill out both fields.", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                let alert = UIAlertController(title: "Error Signing Up", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print(error.localizedDescription)
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
