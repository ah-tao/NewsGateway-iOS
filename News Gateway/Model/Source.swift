//
//  Source.swift
//  News Gateway
//
//  Created by Taotao Ma on 6/12/19.
//  Copyright © 2019 Taotao Ma. All rights reserved.
//

import UIKit


class Source {
    
    let id: String
    let name: String
    let category: String
    let url: String
    
    init(id: String, name: String, category: String, url: String) {
        self.id = id
        self.name = name
        self.category = category
        self.url = url
    }
    
}
