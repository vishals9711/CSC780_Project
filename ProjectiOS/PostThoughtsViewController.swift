//
//  PostThoughtsViewController.swift
//  ProjectiOS
//
//  Created by Khushboo Gandhi on 5/1/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class PostThoughtsViewController: UIViewController {
    
    var db: Firestore!

    @IBOutlet weak var titleTextview: UITextView!
    @IBOutlet weak var descriptionTextview: UITextView!
   
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        setPost()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //giving border to textview
        self.descriptionTextview.layer.borderColor = UIColor.gray.cgColor
        self.descriptionTextview.layer.borderWidth = 1
        self.descriptionTextview.layer.cornerRadius = 15
        
        self.titleTextview.layer.borderColor = UIColor.gray.cgColor
        self.titleTextview.layer.borderWidth = 1
        self.titleTextview.layer.cornerRadius = 15

        // Do any additional setup after loading the view.
        db = Firestore.firestore()
        
    }
    
    private func setPost() {
          // [START set_document_codable]
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        guard let title = titleTextview.text else {return}
        
        guard let description = descriptionTextview.text else {return}
    
    
        let post = Post(title: title, description: description, user_id: userID)
        
        

      do {
          try db.collection("posts").document().setData(post.asDictionary())
      } catch let error {
          print("Error writing city to Firestore: \(error)")
      }
     
      }

    
}
