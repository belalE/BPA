//
//  LoginViewController.swift
//  BPA
//
//  Created by Belal Elsiesy on 11/2/18.
//  Copyright © 2018 Elsiesy Industries. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
 
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    var myUserID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let  email = emailField.text, let pass = passwordField.text {
            
            
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                if user != nil {
                    self.myUserID = user?.user.uid
                    self.performSegue(withIdentifier: "Login", sender: self)
                } else {
                    // error
                    print(error?.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        if let email = emailField.text, let pass = passwordField.text {
            Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                if user != nil {
                    //user is found, go to next screen
                    self.myUserID = user?.user.uid
                    self.performSegue(withIdentifier: "setUpProfile", sender: self)
                } else {
                    //error
                    print(error?.localizedDescription)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is CreateProfileViewController
        {
            let vc = segue.destination as? CreateProfileViewController
            
            vc?.uid = myUserID
            
        } else if segue.destination is FoodTableViewController {
            let vc = segue.destination as! FoodTableViewController
            vc.uid = myUserID
        }
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //dismiss the keyboard when view is tapped on
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
}

    func createAlert(title:String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,  handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.present(alert, animated: true, completion: nil)
        
    }
    


