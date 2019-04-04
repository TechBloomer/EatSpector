//
//  SignInViewController.swift
//  EatSpector
//
//  Created by Pann Cherry on 10/17/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import UIKit
import Firebase;
import FirebaseAuth;

class SignInViewController: UIViewController {
    var handle: AuthStateDidChangeListenerHandle?

    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadingIndicator.isHidden = true;
        
    }
    
    
    @IBAction func onClicked_SignInButton(_ sender: Any) {
        self.loadingIndicator.isHidden = false;
        self.loadingIndicator.startAnimating();
        if let email = self.usernameTextField.text, let password = self.passwordTextField.text {
            
                // [START headless_email_auth]
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    // [START_EXCLUDE]
                    //self.hideSpinner {
                        if let error = error {
                            self.loadingIndicator.isHidden = true;
                        self.loadingIndicator.stopAnimating();
                            let alert = UIAlertController(title: "Error", message: (error.localizedDescription), preferredStyle: .alert);
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
                            self.present(alert, animated: true);
                            return
                        }
                        else{
                            self.loadingIndicator.stopAnimating();
                            self.loadingIndicator.isHidden = true;
                            //self.navigationController!.popViewController(animated: true)
                            self.performSegue(withIdentifier: "logInSegue", sender: (Any).self);
                    }
                    // [END_EXCLUDE]
                }
                // [END headless_email_auth]
            
        } else {

            self.loadingIndicator.stopAnimating();
            self.loadingIndicator.isHidden = true;
            let alert = UIAlertController(title: "Error", message: "Email or password can't be empty", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
            self.present(alert, animated: true);
        }
    }
    
    
    @IBAction func onClick_withoutAccountButton(_ sender: Any) {
        print("clicked continue without account button");
        self.loadingIndicator.stopAnimating();
        self.loadingIndicator.isHidden = true;
        //self.navigationController!.popViewController(animated: true)
        self.performSegue(withIdentifier: "logInSegue", sender: (Any).self);
    }
    
    
    @IBAction func onClick_MainButton(_ sender: Any) {
        print("clicked continue without account button");
        self.loadingIndicator.stopAnimating();
        self.loadingIndicator.isHidden = true;
        //self.navigationController!.popViewController(animated: true)
        self.performSegue(withIdentifier: "mainSegue", sender: (Any).self);
    }
    
    
}

