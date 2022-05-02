//
//  Post.swift
//  ProjectiOS
//
//  Created by Khushboo Gandhi on 5/1/22.
//

import Foundation

struct Post: Codable{
    let title: String
    let description: String
    let user_id: String
    
 
}

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}

