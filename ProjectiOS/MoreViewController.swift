//
//  MoreViewController.swift
//  ProjectiOS
//
//  Created by Khushboo Gandhi on 4/28/22.
//

import UIKit
import FirebaseAuth

class MoreViewController: UIViewController {

    var handle: AuthStateDidChangeListenerHandle?
    @IBAction func signOutBtnPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            //redirect to sign in page
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated: true, completion: nil)
            
        } catch {
          print("Sign out error")
            let alert = UIAlertController(title: "Error", message: "An error occurred while trying to sign out!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
