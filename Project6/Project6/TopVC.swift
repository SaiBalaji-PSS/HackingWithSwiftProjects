//
//  ViewController.swift
//  Project6
//
//  Created by Sai Balaji on 30/06/20.
//

import UIKit

class TopVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    var detail: String!
    var urlString: String!
    var signatures: Int!
    var petitions = [Petition]()

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
      
       urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
       
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Top petitions"
       
        
        
        
        
     if let url = URL(string: urlString)
     {
        if let data = try? Data(contentsOf: url)
        {
            parseJSON(json: data)
        }
     }
        
        
        
    }
    
    
    func parseJSON(json: Data)
    {
        do
        {
            let decodedData = try JSONDecoder().decode(Petitions.self, from: json)
            petitions = decodedData.results
            tableview.reloadData()
            print(petitions)
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        detail = petitions[indexPath.row].body
        signatures = petitions[indexPath.row].signatureCount
        
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? DetailVC
        {
            destinationVC.detailItem = detail
            destinationVC.count = signatures
        }
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableview.dequeueReusableCell(withIdentifier: "Cell")
        {
            let p = petitions[indexPath.row]
            cell.textLabel?.text = p.title
            cell.detailTextLabel?.text = p.body
            
            return cell
        }
        
        
        return UITableViewCell()
        
    }


}

