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
    
    
}
