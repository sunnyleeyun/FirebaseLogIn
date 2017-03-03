//
//  ViewController.swift
//  FirebaseLogIn
//
//  Created by Mac on 2017/2/28.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class ViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
        let logInButton = FBSDKLoginButton()
        view.addSubview(logInButton)
        logInButton.frame = CGRect(x: 16, y: 250, width: view.frame.width - 32, height: 50)
        
        logInButton.delegate = self
 */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did Log Out of Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print(error)
            return
        }
        
        print("Succesfully Log In with Facebook!")
    }
    */
    
    @IBAction func facebookLogin(_ sender: Any) {
        
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let nextVC = storyboard.instantiateViewController(withIdentifier: "ConfirmID")as! ConfirmViewController
                self.present(nextVC,animated:true,completion:nil)
            })
            
        }
    }

}

