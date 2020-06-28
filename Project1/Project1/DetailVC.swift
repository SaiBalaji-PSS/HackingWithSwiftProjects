//
//  DetailVC.swift
//  Project1
//
//  Created by Sai Balaji on 28/06/20.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var imageview: UIImageView!
    var imagename:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
         title = imagename!
        navigationItem.largeTitleDisplayMode = .never
        imageview.image = UIImage(named: imagename!)

       
    }
    

  

}
