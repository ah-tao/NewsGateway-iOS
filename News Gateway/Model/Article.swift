//
//  Article.swift
//  News Gateway
//
//  Created by Taotao Ma on 6/12/19.
//  Copyright © 2019 Taotao Ma. All rights reserved.
//

import UIKit


class Article {
    
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    
    init(author: String, title: String, description: String, url: String, urlToImage: String, publishedAt: String) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
    
}
