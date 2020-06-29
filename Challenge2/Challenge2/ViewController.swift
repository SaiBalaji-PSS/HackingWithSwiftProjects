//
//  ViewController.swift
//  Challenge2
//
//  Created by Sai Balaji on 29/06/20.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var selectedWebsite: String!
   
    @IBOutlet weak var websitetableview: UITableView!
    
    let websites = ["Google","Bing","Wikipedia","Yahoo"]
    let infosites = ["Apple","Android","Samsung","Microsoft"]
    let newssites = ["WashingtonPost","NyTimes"]
    let learningsites = ["FreeCodeCamp","JapanesePod101","HackingWithSwift","GitHub"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        websitetableview.delegate = self
        websitetableview.dataSource = self
        
        title = "Website List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        
        
      
        
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0
        {
        return websites.count
        }
        
        else if section == 1
        {
            return infosites.count
        }
        
        else if section == 2
        {
            return newssites.count
        }
        
        else if section == 3
        {
            return learningsites.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "websitecell")
            {
                cell.textLabel?.text = websites[indexPath.row]
                return cell
            }
            
        }
        
        else if indexPath.section == 1
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "websitecell")
            {
                cell.textLabel?.text = infosites[indexPath.row]
                return cell
            }
        }
        
        
        else if indexPath.section == 2
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "websitecell")
            {
                cell.textLabel?.text = newssites[indexPath.row]
                
                return cell
            }
        }
        
        else if indexPath.section == 3
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "websitecell")
            {
                cell.textLabel?.text = learningsites[indexPath.row]
                return cell
            }
        }
      
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if  indexPath.section == 0
        {
            selectedWebsite = websites[indexPath.row]
        }
        
        else if indexPath.section == 1
        {
            selectedWebsite = infosites[indexPath.row]
        }
        
        else if indexPath.section == 2
        {
            selectedWebsite = newssites[indexPath.row]
        }
        else if indexPath.section == 3
        {
            selectedWebsite = learningsites[indexPath.row]
        }
        
        performSegue(withIdentifier: "segue", sender: self)
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            return "Search"
        }
        else if section == 1
        {
            return "Tech Companies"
        }
        
        else if section == 2
        {
            return "News"
        }
        
        else if section == 3
        {
            return "Learning"
        }
        
        return ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? BrowserVC
        {
            destinationVC.websitename = selectedWebsite
        }
        
    }
}

