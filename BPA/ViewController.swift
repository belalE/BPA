//
//  ViewController.swift
//  BPA
//
//  Created by Belal Elsiesy on 11/2/18.
//  Copyright © 2018 Elsiesy Industries. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        if let  email = emailTextField.text, let pass = passwordTextField.text {
            
        
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "Login", sender: self)
            } else {
                // error
            }
        }
        }
        }
    
    
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let pass = passwordTextField.text {
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if user != nil {
                //user is found, go to next screen
                self.performSegue(withIdentifier: "setUpProfile", sender: self)
            } else {
                //error
            }
        }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //dismiss the keyboard when view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}
    


