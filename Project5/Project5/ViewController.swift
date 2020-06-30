//
//  ViewController.swift
//  Project5
//
//  Created by Sai Balaji on 30/06/20.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var wordtableview: UITableView!
    
    var allwords = [String]()
    var usedwords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Welcome message
        
        let welcomemessage = UIAlertController(title: "Welcome", message: " 1) Build as many anagrams from the given word\n 2) Try to get new words by pressing refresh button", preferredStyle: .alert)
        welcomemessage.addAction(UIAlertAction(title: "Got it!", style: .default, handler: nil))
        
        
        present(welcomemessage, animated: true, completion: nil)
        
        
        //Navigation bar items
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target:self, action: #selector(promptForInput))
        
        navigationController?.isToolbarHidden = false
        
        let refreshbtn = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(gameStart))
        
        toolbarItems = [refreshbtn]
        
        
        
        
        
        //Table view delegate
        wordtableview.delegate = self
        wordtableview.dataSource = self
           
        //Loading words from a text file
           if  let starturl =  Bundle.main.url(forResource: "start", withExtension: ".txt")
           {
            
            do
            {
             let startwords =  try String(contentsOf:starturl)
             
                allwords = startwords.components(separatedBy: "\n")
              
            }
            catch
            {
                print(error.localizedDescription)
            }
       }
        
        
        if allwords.isEmpty
        {
            allwords = ["sample"]
        }
            
        gameStart()
        
    }
    
    
    @objc func gameStart()
    {
        
        title = allwords.randomElement()
        
        //Remove previous word entries
        usedwords.removeAll(keepingCapacity: true)
        
        wordtableview.reloadData()
    }
    
    
    @objc func promptForInput()
    {

        let ac = UIAlertController(title: "Enter your answer", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        ac.textFields![0].placeholder = "Answer"
        ac.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (alertaction) in
            
            if ac.textFields![0].text != ""
            {
              if  let answer = ac.textFields?[0].text
             {
              print(answer)
                self.addAnswer(answer: answer)
             }
            }
        }))
        
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(ac, animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedwords.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "wordcell")
        
        {
            cell.textLabel?.text = usedwords[indexPath.row]
            return cell
        }
        else
        {
            return UITableViewCell()
        }
        
    }
    
    func addAnswer(answer: String)
    {
        
        
        if allwords.contains(answer)
        {
            
            let ac = UIAlertController(title: "Info", message: "This word already exist try a different word", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(ac, animated: true, completion: nil)
            
           
        }
        
        
        else if !isWrongword(answer: answer)
        {
            let ac = UIAlertController(title: "Info", message: "Please enter a proper english word", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(ac, animated: true, completion: nil)

        }
        else
        {
        usedwords.insert(answer, at: 0)
        wordtableview.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
        
    }
    

    func isWrongword(answer: String) -> Bool
    {
       let checker = UITextChecker()
        
        
        //We wroking with UIKit use utf16 for count to get backward compatibility with Objective C strings
        let range = NSRange(location: 0, length: answer.utf16.count)
        
        let misspelledrange = checker.rangeOfMisspelledWord(in: answer, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledrange.location == NSNotFound
      
    }
    
    

}

