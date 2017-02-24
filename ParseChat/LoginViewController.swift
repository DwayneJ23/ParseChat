//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Dwayne Johnson on 2/23/17.
//  Copyright © 2017 Dwayne Johnson. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {


    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let missingUserEmailAlert = UIAlertAction(title: "OK", style: destructive, handler: nil)
        alertController.addAction(missingUserEmailAlert)
        present(alertController, animated: true, completion: nil)
    }
    
    private func getUserCredentials() -> (name: String, email: String, password: String)? {
        var name = "", email = "", password = ""
        
        if let userEmail = userEmailTextField.text, userEmail != "" {
            name = userEmail
            email = userEmail
        }
        else {
            showAlert(message: "Missing Email!")
            return nil
        }
        if let userPassword = userPasswordTextField.text, userPassword != "" {
            password = userPassword
        }
        else {
            showAlert(message: "Missing Password!")
            return nil
        }
        return (name, email, password)
    }

    @IBAction func onSignupButton(_ sender: UIButton) {
        if let userCredentials = getUserCredentials() {
            let user = PFUser()
            user.username = userCredentials.name
            user.email = userCredentials.email
            user.password = userCredentials.password
            
            user.signUpInBackground { (success, error) in
                if let error = error {
                    self.showAlert(message: error.localizedDescription)
                }
                else {
                    self.performSegue(withIdentifier: "toUserFeed", sender: nil)
                }
            }
        }
    }
    
    @IBAction func onLoginButton(_ sender: UIButton) {
        if let userCredential = getUserCredentials() {
            PFUser.logInWithUsername(inBackground: userCredential.email, password: userCredential.email, block: { (user, error) in
                if user != nil {
                    self.performSegue(withIdentifier: "toUserFeed", sender: nil)
                }
                else {
                    self.showAlert(message: "Could not log in. Please try again!")
                }
            })
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
