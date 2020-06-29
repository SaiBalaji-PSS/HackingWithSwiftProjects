//
//  ViewController.swift
//  Challenge1
//
//  Created by Sai Balaji on 29/06/20.
//

import UIKit

class FlagNameVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    

    var countries = [String]()
    
    @IBOutlet weak var countrytableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items
        {
            if item.contains("png")
            {
                countries.append(item)
            }
        }
        
        
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
       
        
        countrytableview.delegate = self
        countrytableview.dataSource = self
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "countrycell")
        {
            cell.textLabel?.text = countries[indexPath.row]
            return cell
        }
        
        else
        {
            return UITableViewCell()
        }
        
        
        
    }
    
    
    


}

