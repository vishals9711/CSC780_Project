//
//  NewsViewController.swift
//  ProjectiOS
//
//  Created by Khushboo Gandhi on 4/28/22.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var articleHeading: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleDescription: UITextView!
    
}



class NewsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let networking = Networking()
    var articles: [Article] = []

    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        super.viewDidLoad()
        Task{
            do{
                let tempArticles = try await networking.fetchRecentArticles();
                articles = tempArticles.articles
                tableView.reloadData()

            }
            

        }

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCellTemp") as? ArticleCell else {
            return UITableViewCell()
        }
        
        let article = articles[indexPath.row];
        print("***")
        cell.articleHeading?.text = (article.title ?? "SOmthing").isEmpty ? "No Titlle" : article.title;
        cell.articleDescription?.text = (article.description ?? "somthing").isEmpty ? "No Description" : article.description;
//        let tempImageURL:URL = URL(string : article.urlToImage ?? "")!
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
