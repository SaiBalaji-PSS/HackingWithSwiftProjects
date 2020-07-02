//
//  ViewController.swift
//  Project8
//
//  Created by Sai Balaji on 01/07/20.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
  var people = [Person]()
    let userdefault = UserDefaults.standard
    @IBOutlet weak var personcollectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personcollectionview.delegate = self
        personcollectionview.dataSource = self
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(pickImage))
        
        navigationController?.isToolbarHidden = false
        
        
        let deletebtn = UIBarButtonItem(title: "Delete All", style: .plain, target: self, action: #selector(deleteall))
        
        
        toolbarItems = [deletebtn]
        
        title = "Face to Name"
        
        
        //Fetch the DataObject back
       if let dataToBeFetched = userdefault.object(forKey: "people") as? Data
       {
          //unarchiveTopLevelObjectWithData() method of NSKeyedUnarchiver to convert Data object  back to an object graph – i.e., our array of Person objects.
        if let peopledata = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dataToBeFetched) as? [Person]{
            people = peopledata
        }
        
       }
        
        
        
    }
    
    
    @objc func deleteall()
    {
        userdefault.removeObject(forKey: "people")
        people.removeAll()
        
        
        personcollectionview.reloadData()
    }
    
    
    
    
    
    @objc func pickImage()
    {
        let picker = UIImagePickerController()
           picker.allowsEditing = true
           picker.delegate = self
        picker.sourceType = .photoLibrary
           present(picker, animated: true)
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
        let imagename = UUID().uuidString
        let imagepath = getDocumentDirectory().appendingPathComponent(imagename)
        
       // print(imagepath.absoluteString)
        
        if let jpegimage = image.jpegData(compressionQuality: 0.9)
        {
            do
            {
                try jpegimage.write(to: imagepath)
                
            }
            
            catch
            {
                print(error.localizedDescription)
            }
        }
        
        
        
        let p = Person(name: "Unknown", image: imagename)
        
        people.append(p)
        personcollectionview.reloadData()
        
        
        
        
        
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    func getDocumentDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func saveData()
    {
        do
        {
            //archivedData() method of NSKeyedArchiver, which turns an object graph into a Data object
            let dataToBeSaved = try NSKeyedArchiver.archivedData(withRootObject: people, requiringSecureCoding: false)
            
            
            //Save the data
            userdefault.set(dataToBeSaved,forKey: "people")
            
            
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let p = self.people[indexPath.row]
        
        let ac = UIAlertController(title: "Add name", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        ac.textFields![0].placeholder = "Enter a name"
        
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
             
            let newname = ac.textFields![0].text
            p.name = newname!
            self.personcollectionview.reloadData()
            
            self.saveData()
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style:.cancel, handler: nil))
       
        
        present(ac, animated: true, completion: nil)
        
        
        
        
        
        
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PersonCell
        {
            let pp = people[indexPath.row]
            cell.personName.text = pp.name
            let path = getDocumentDirectory().appendingPathComponent(pp.image)
            
            print(path.path)
            
            cell.personImage.image = UIImage(contentsOfFile: path.path)
            
            
            
            cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 5
            
            
            
            return cell
        }
        
        
        return UICollectionViewCell()
        
        
        
        
    }
    
    
    
    
    
    
    
    


}

