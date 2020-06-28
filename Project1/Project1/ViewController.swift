//
//  ViewController.swift
//  Project1
//
//  Created by Sai Balaji on 28/06/20.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    
   
    @IBOutlet weak var listtableview: UITableView!
    var images = [String]()
    var selectedimage:String!
  
    override func viewDidLoad() {
        super.viewDidLoad()
         
        navigationController?.navigationBar.prefersLargeTitles = true
       
      
        let fm = FileManager.default
        
        let path = Bundle.main.resourcePath!
        
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items
        {
            if item.hasPrefix("ns")
            {
                images.append(item)
                print(images)
            }
           
        }
      
        
        listtableview.delegate = self
        listtableview.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if   let cell = tableView.dequeueReusableCell(withIdentifier: "Picture")
        
      {
        
        cell.textLabel?.text = images[indexPath.row]
        
        return cell
      }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
            return "Strom Viewer"
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         selectedimage = images[indexPath.row]
        print(selectedimage!)
        performSegue(withIdentifier: "segue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? DetailVC
        {
            destination.imagename = selectedimage!
        }
        
    }
    
    
    


}

