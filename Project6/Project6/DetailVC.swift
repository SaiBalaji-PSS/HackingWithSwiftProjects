//
//  DetailVC.swift
//  Project6
//
//  Created by Sai Balaji on 30/06/20.
//

import UIKit

class DetailVC: UIViewController {

    
  
    var detailItem: String?
    var count: Int!
    
    
    @IBOutlet weak var datalbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never

       
        
        title = String(count!)
        datalbl.text = detailItem!
    }
    


}
