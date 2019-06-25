//
//  HeadlinesViewController.swift
//  News Gateway
//
//  Created by Taotao Ma on 6/12/19.
//  Copyright © 2019 Taotao Ma. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import SDWebImage


class HeadlinesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /**
     * News Article Query Format:
     * https://newsapi.org/v2/top-headlines?sources=______&apiKey=______
     *
     * NewsAPI.org Articles Query Results Example:
     * https://newsapi.org/v2/top-headlines?pageSize=10&sources=______&apiKey=______
     */
    let URL_HEAD: String = "https://newsapi.org/v2/top-headlines?pageSize=50&sources="
    let URL_API: String = "&apiKey=a35be4b61bef444f99a0a6d1e30f1c77"
    
    var source: Source!
    var headlines: [Article] = [Article]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = source.name

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
        
        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: .none, queue: OperationQueue.main) { [weak self] _ in
            self?.tableView.reloadData()
        }

        getHeadlines()
    }
    
    //MARK: - TableView DataSource Methods
    //TODO: Declare cellForRowAtIndexPath here:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! HeadlinesTableViewCell
        let article = headlines[indexPath.row]
        cell.topImageView.sd_setImage(with: URL(string: article.urlToImage))
        cell.authorLabel.text = article.author
        cell.dateLabel.text = article.publishedAt
        cell.titleLabel.text = article.title
        cell.detailTextView.text = article.description
        cell.selectionStyle = .none
        
        return cell
    }
    
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    
    //MARK: - TableView Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
    
    //MARK: - Prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WebViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            destination.articleURL = headlines[indexPath.row].url
        }
    }

    
    //MARK: - Utils
    // get headlines using source id
    func getHeadlines() {
        SVProgressHUD.show()
        
        if let url = URL(string: URL_HEAD + source.id + URL_API) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let json = try JSON(data: data)
                        if let articles = json["articles"].array {
                            for articleJson in articles {
                                let author: String = articleJson["author"].stringValue
                                let title: String = articleJson["title"].stringValue
                                let description: String = articleJson["description"].stringValue
                                let urlToDetail: String = articleJson["url"].stringValue
                                let urlToImage: String = articleJson["urlToImage"].stringValue
                                let publishedAt: String = self.getLocalDate(articleJson["publishedAt"].stringValue)
                                let article = Article(author: author, title: title, description: description, url: urlToDetail, urlToImage: urlToImage, publishedAt: publishedAt)
                                self.headlines.append(article)
                            }
                            DispatchQueue.main.async {
                                SVProgressHUD.dismiss()
                                self.tableView.reloadData()
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
    
    
    func getLocalDate(_ string: String) -> String {
        // modify date format
        return string
    }

    
}
