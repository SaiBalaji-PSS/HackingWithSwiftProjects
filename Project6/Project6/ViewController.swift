//
//  ViewController.swift
//  Project6
//
//  Created by Sai Balaji on 30/06/20.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    var detail: String!
    var urlString: String!
    var signatures: Int!
    var petitions = [Petition]()

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "White House Petitions"
        
        
        tableview.delegate = self
        tableview.dataSource = self
        if navigationController?.tabBarItem.tag == 0
        {
       urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }
        
        
        
     if let url = URL(string: urlString)
     {
        DispatchQueue.global(qos: .userInteractive).async {
            if let data = try? Data(contentsOf: url)
            {
                self.parseJSON(json: data)
            }
        }
        
        
     }
        
        
        
    }
    
    
    func parseJSON(json: Data)
    {
        
            DispatchQueue.main.async {
                
                do
                {
                let decodedData = try JSONDecoder().decode(Petitions.self, from: json)
                    self.petitions = decodedData.results
                    self.tableview.reloadData()
                    print(self.petitions)
                }
                
                catch
                {
                    print(error.localizedDescription)
                }
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

