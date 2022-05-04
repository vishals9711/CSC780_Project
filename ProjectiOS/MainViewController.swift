//
//  ViewController.swift
//  ProjectiOS
//
//  Created by Khushboo Gandhi on 4/28/22.
//

import UIKit
import FirebaseAuth


class MainViewController: UIViewController {
    var handle: AuthStateDidChangeListenerHandle?

    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //start Auth Listener
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            if let user = user {
                // User is signed in
                // let the user in?
                print("User is signed in")

                            
            } else {
                // No user and redirect to sign up page.
                print("redirecting to sign up page")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let nextViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
                nextViewController.modalPresentationStyle = .fullScreen
                self.present(nextViewController, animated: true, completion: nil)
                
                            
            }
        })
        
        

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    


}
