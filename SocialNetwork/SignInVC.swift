//
//  SignInVC.swift
//  SocialNetwork
//
//  Created by Arman on 11/28/16.
//  Copyright © 2016 InnorieseEntertainment. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import  Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailFiled: FancyField!
    @IBOutlet weak var passwdField: FancyField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func facebookBtnTapped(_ sender: AnyObject) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Arman: Unable to auth with facebook")
            } else if result?.isCancelled == true {
                print("Arman: User canceled auth")
            } else {
                print("Arman: Succsess with FBook")
                let credental = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.fireBaseAuth(credental)
            }
        }
    }
    
    func fireBaseAuth(_ credental: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credental, completion: { (user, error) in
            if error != nil {
                print("Arman: Unable to auth with facebook")
            } else {
                print("Arman: Succsess with FBase")
            }
        })
    }
    
    @IBAction func signInTapped(_ sender: AnyObject) {
        if let email = emailFiled.text, let pass = passwdField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: { (user, error) in
                if error == nil {
                    print("Arman: Email user authenticated with Firebase")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pass, completion: { (user, error) in
                        if error != nil {
                            print("Arman: Unable to authenticate with Firebase with email")
                        } else {
                            print("Arman: Success authenticate with Firebase")
                        }
                    })
                }
            })
        }
    }
    
}
