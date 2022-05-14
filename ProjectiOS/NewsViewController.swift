//
//  NewsViewController.swift
//  ProjectiOS
//
//  Created by Khushboo Gandhi on 4/28/22.
//

import UIKit
import Foundation
import SwiftUI
import FirebaseAuth



class NewsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let networking = Networking()
    var articles: [Article] = []
    var handle: AuthStateDidChangeListenerHandle?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        
        navigationItem.title = "Balanced Minds"
        Task{
            do{
                let date = Date();
                let df = DateFormatter();
                df.dateFormat = "yyyy-MM-dd"
                let dateString = df.string(from:date);
                
                let tempArticles = try await networking.fetchRecentArticles(date:dateString);
                articles = tempArticles.articles
                tableView.reloadData()

            }
            

        }

        // Do any additional setup after loading the view.
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
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCellTemp") as? ArticleCell else {
            return UITableViewCell()
        }
        
        let article = articles[indexPath.row];
        cell.articleHeading?.text = (article.title ?? "Title").isEmpty ? "No Title" : article.title;
        cell.articleDescription?.text = (article.description ?? "somthing").isEmpty ? "No Description" : article.description;
        
        let url = article.urlToImage ?? ""
        cell.articleImage.loadFrom(URLAddress: url)

//        cell.articleImage.load(url: tempImageURL)
        return cell;

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToWebViewSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let webViewController = segue.destination as? WebViewController else{
            return
        }
        
       
        guard let indexPath = sender as? IndexPath else {
            return
        }
        
        let articleUrl = articles[indexPath.row].url;
        webViewController.articleUrl = articleUrl;

    }

}
