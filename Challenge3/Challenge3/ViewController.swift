//
//  ViewController.swift
//  Challenge3
//
//  Created by Sai Balaji on 30/06/20.
//

import UIKit
import MessageUI

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var sharebtn: UIBarButtonItem!
    var items = [String]()
    
    @IBOutlet weak var itemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        itemTableView.dataSource = self
        itemTableView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(promptInput))
        
        navigationController?.isToolbarHidden = false
        
        
        sharebtn = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharelist))
        
        toolbarItems = [sharebtn]
       
        
    }
    
    @objc func sharelist()
    {
        if items.isEmpty
        {
            let ac = UIAlertController(title: "Info", message: "Please add atleast one item to share", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(ac, animated: false, completion: nil)
            
            return
        }
        
      
        let itemstring = items.joined(separator: "\n")
        
        
        let vc = UIActivityViewController(activityItems: [itemstring], applicationActivities: [])
        
        vc.popoverPresentationController?.sourceView = self.view
        
        present(vc, animated: true, completion: nil)
}
    
    @objc func promptInput()
    {
        let ac = UIAlertController(title: "New item", message:nil, preferredStyle: .alert)
        
        ac.addTextField()

        ac.textFields![0].placeholder = "Enter your item here"


        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { (alertaction) in
            let item = ac.textFields![0].text
            self.addItem(itemtobeAdded: item!)
          
        }))
        
        
          ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
          
        present(ac, animated: true, completion: nil)
    }
    
    
    func addItem(itemtobeAdded: String)
    {
        if itemtobeAdded != ""
        {
        items.insert(itemtobeAdded, at: 0)
        itemTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
        
        else
        {
            let ac = UIAlertController(title: "Info", message: "Please add an item", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
         
            
            present(ac, animated: false, completion: nil)
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell")
        {
            cell.textLabel?.text = items[indexPath.row]
            return cell
        }
        
        
        return UITableViewCell()
    }


}

