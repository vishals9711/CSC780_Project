//
//  NewsViewController.swift
//  ProjectiOS
//
//  Created by Khushboo Gandhi on 4/28/22.
//

import UIKit


class ArticleCell: UITableViewCell {
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as? ArticleCell else {
            print("11111")
            return UITableViewCell()
        }
        
        let article = articles[indexPath.row];
        print("***")
        cell.textLabel?.text = (article.title ?? "").isEmpty ? "No Author" : article.title;
        return cell;

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(articles[indexPath.row]);
        return;
    }

}
