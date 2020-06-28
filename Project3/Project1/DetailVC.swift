//
//  DetailVC.swift
//  Project1
//
//  Created by Sai Balaji on 28/06/20.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var sharebtn: UIBarButtonItem!
    @IBOutlet weak var imageview: UIImageView!
    var imagename:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = imagename!
        navigationItem.largeTitleDisplayMode = .never
        imageview.image = UIImage(named: imagename!)
      
    }
    
    
    
    @IBAction func sharebtntapped(_ sender: UIBarButtonItem) {
        
        guard let imagetoshared = imageview.image?.jpegData(compressionQuality: 0.9) else
        {
            print("Image not found")
            return
        }
        
        
        
        let vc = UIActivityViewController(activityItems: [imagetoshared], applicationActivities: [])
        vc.isModalInPresentation = true 
        vc.popoverPresentationController?.barButtonItem = sharebtn
        present(vc, animated: true, completion: nil)
        
    }
    
  

}
