//
//  ArticleCell.swift
//  ProjectiOS
//
//  Created by Khushboo Gandhi on 4/28/22.
//

import Foundation
import UIKit


extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    print(loadedImage)
                        self?.image = loadedImage
                }
            }
        }
    }
}

class ArticleCell: UITableViewCell {
    

    @IBOutlet weak var articleHeading: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var articleDescription: UILabel!
    
    
}

