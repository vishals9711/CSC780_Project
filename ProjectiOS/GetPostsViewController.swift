//
//  GetPostsViewController.swift
//  ProjectiOS
//
//  Created by Khushboo Gandhi on 5/3/22.
//

import UIKit
import FirebaseFirestore



class GetPostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var tableview: UITableView!
    
    var db: Firestore!
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        
        //firebase
        db = Firestore.firestore()
        
        getData();
        self.tableview.reloadData();
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellTemp") as? PostCell else {
            return UITableViewCell()
        }
        
        let post = posts[indexPath.row]
        cell.postTitle?.text = post.title;
        cell.postDescription?.text = post.description;
        return cell
    }
    


    func getData(){
        db.collection("posts")
            .order(by: "date_created",  descending: true)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.posts = documents.map{(queryDocumentSnapshot)-> Post in
                    let data = queryDocumentSnapshot.data();
                    let title:String = data["title"] as! String ?? "Title";
                    let description:String = data["description"] as! String ?? "description";
                    let user_id = data["user_id"] as! String ?? "user_id";
                    let date_created = Date()
                    return Post(title: title, description: description, user_id: user_id,date_created: date_created)
                }
                self.tableview.reloadData()
                
                
                
            }

    }

}
