//
//  NewsArticle.swift
//  ProjectiOS
//
//  Created by Khushboo Gandhi on 4/28/22.
//

import Foundation

struct RecentArticles:Codable{
let articles:[Article]
}

struct Article:Codable{
    let author:String?
    let title:String?
    let description:String?
    let url:String?
    let urlToImage:String?
    let content:String?
    
}
