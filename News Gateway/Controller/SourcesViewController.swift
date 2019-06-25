//
//  SourcesViewController.swift
//  News Gateway
//
//  Created by Taotao Ma on 6/12/19.
//  Copyright © 2019 Taotao Ma. All rights reserved.
//

import UIKit


class SourcesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let ICON_URL: String = "https://besticon-demo.herokuapp.com/icon?size=48..96..192&formats=png&url="
    
    var category: String!
    var sources: [Source]!
    
    @IBOutlet weak var sourcesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = category
        
        sourcesTableView.delegate = self
        sourcesTableView.dataSource = self
    }
    
    
    // prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HeadlinesViewController,
            let indexPath = sourcesTableView.indexPathForSelectedRow {
            destination.source = sources[indexPath.row]
        }
    }

    
    //MARK: - TableView DataSource Methods
    //TODO: Declare cellForRowAtIndexPath here:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourceCell", for: indexPath) as! SourcesTableViewCell
        
        cell.sourceIcon.sd_setImage(with: URL(string: ICON_URL + sources[indexPath.row].url), placeholderImage: UIImage(named: "placeholder"))
        cell.sourceLabel.text = sources[indexPath.row].name
        cell.selectionStyle = .none
        
        return cell
    }
    
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    
    
    
}
