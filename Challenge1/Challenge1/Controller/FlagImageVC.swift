//
//  FlagImageVC.swift
//  Challenge1
//
//  Created by Sai Balaji on 29/06/20.
//

import UIKit

class FlagImageVC: UIViewController {

    @IBOutlet weak var sharebutton: UIBarButtonItem!
    @IBOutlet weak var flagimageView: UIImageView!
    var selectedimage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let si = selectedimage
        {
            title = si
            flagimageView.image = UIImage(named: si)
        }
        
        
        
       
    }
    
    
    @IBAction func sharebtn(_ sender: Any) {
        
        guard let image = flagimageView.image?.jpegData(compressionQuality: 0.9) else{
            print("No image found")
            return
        }
        
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = sharebutton
        present(vc, animated: true, completion: nil)
        
        
    }
    

}
