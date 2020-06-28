//
//  ViewController.swift
//  Project2
//
//  Created by Sai Balaji on 28/06/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var correctanswer = 0
    var countries = [String]()
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")
        
        button1.layer.borderWidth = 2
        button1.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button1.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button1.layer.shadowOpacity = 10
        
        button2.layer.borderWidth = 2
        button2.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button2.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button2.layer.shadowOpacity = 10
        
        button3.layer.borderWidth = 2
        button3.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button3.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button3.layer.shadowOpacity = 10
        

        getQuestion()
        
    }

    
    @IBAction func playagainbtn(_ sender: UIBarButtonItem) {
        
        getQuestion()
    }
    
    func getQuestion()
    {
        countries.shuffle()
        correctanswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        print(countries[0])
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        print(countries[1])
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        print(countries[2])
        
        title = "Guess the Flag of \(countries[correctanswer].uppercased())"
    }

    @IBAction func ButtonTapped(_ sender: UIButton) {
        
        if sender.tag == correctanswer
        {
            title = "Correct!!!"
            score += 1
        }
        
        else
        {
            title = "Worng :("
            score -= 1
            if score <= 0
            {
                score = 0
            }
        }
        
    }
    
    
    @IBAction func scorebtntapped(_ sender: UIBarButtonItem) {
        
        if score == 0
        {
            let alertcontroller = UIAlertController(title: "Info", message: "Play atleast once to get your score", preferredStyle: .alert)
            alertcontroller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alertcontroller, animated: true, completion: nil)
        }
        
        else
        {
            let alertcontroller = UIAlertController(title: "Info", message: "Your score is \(score)", preferredStyle: .alert)
            alertcontroller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alertcontroller, animated: true, completion: nil)
        }
    }
    
    
    
}

