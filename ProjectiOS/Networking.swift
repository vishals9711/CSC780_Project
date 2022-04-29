//
//  Networking.swift
//  ProjectiOS
//
//  Created by Khushboo Gandhi on 4/28/22.
//

import Foundation

struct Networking {
    
    let baseURLString = "https://newsapi.org/v2/everything?q=apple&from=2022-04-28&to=2022-04-28&sortBy=popularity&apiKey=4b7e77b7c8994fb9984d80d1feb4bd95";
    func fetchRecentArticles() async throws -> RecentArticles {
        let url = URL(string: baseURLString)!
        print(url)
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(RecentArticles.self, from: data)
    }

}
