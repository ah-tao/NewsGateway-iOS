//
//  CategoryViewController.swift
//  News Gateway
//
//  Created by Taotao Ma on 6/7/19.
//  Copyright © 2019 Taotao Ma. All rights reserved.
//

import UIKit
import SwiftyJSON
import SVProgressHUD

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Declare instance variables here
    var categoryList: [String] = [String]()
    var sourceMap: [String: [Source]] = [String: [Source]]()
    var sourceList: [Source] = [Source]()
    
    // Declare Constants here
    /**
     * To get all sources:
     * https://newsapi.org/v2/sources?language=en&country=us&apiKey=____________
     */
    let URL_HEAD: String = "https://newsapi.org/v2/sources?language=en&country=us"
    let URL_API: String = "&apiKey=a35be4b61bef444f99a0a6d1e30f1c77"
    
    
    // Link IBOutlets
    @IBOutlet weak var categoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Set yourself as the delegate and datasource here:
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        title = "Category"
        prepareData()
    }
    
    // segue prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SourcesViewController,
            let indexPath = categoryTableView.indexPathForSelectedRow {
            destination.sources = sourceMap[categoryList[indexPath.row]]
            destination.category = categoryList[indexPath.row]
        }
    }
    
    
    //MARK: - TableView DataSource Methods
    //TODO: Declare cellForRowAtIndexPath here:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        
        cell.categoryIcon.image = UIImage(named: categoryList[indexPath.row])
        cell.categoryLabel.text = categoryList[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    
    //MARK: - Prepare Data
    //TODO: Prepare Data for category table view and sources table view
    func prepareData() {
        SVProgressHUD.show()
        if let url = URL(string: URL_HEAD + URL_API) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let json = try JSON(data: data)
                        if let sources = json["sources"].array {
                            for sourceJson in sources {
                                let id: String = sourceJson["id"].stringValue
                                let name: String = sourceJson["name"].stringValue
                                let category: String = sourceJson["category"].stringValue.capitalizingFirstLetter()
                                let urlToIcon: String = sourceJson["url"].stringValue
                                let source = Source(id: id, name: name, category: category, url: urlToIcon)
                                self.sourceList.append(source)
                            }
                            self.formatData()
                            DispatchQueue.main.async {
                                SVProgressHUD.dismiss()
                                self.categoryTableView.reloadData()
                            }
                        }
                    } catch {
                        print(error)
                    }
                } else {
                    print("Data Error")
                }
            }.resume()
        } else {
            print("URL Error")
        }
        
    }
    
    //TODO: reformat datatype
    func formatData() {
        var categorySet = Set<String>()
        categorySet.insert("All")
        sourceMap["All"] = self.sourceList
        for source in self.sourceList {
            if categorySet.insert(source.category).inserted {
                sourceMap[source.category] = [Source]()
            }
            sourceMap[source.category]?.append(source)
        }
        categoryList = categorySet.sorted()
    }
        
}


// Capitalize first letter
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}



