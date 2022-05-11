//
//  ViewController.swift
//  HighScore
//
//  Created by Christopher Walter on 5/10/22.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var count = 0
    
    var highScore = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       loadData()
    }
    
    func saveData()
    {
        let defaults = UserDefaults.standard
        defaults.setValue(count, forKey: "highScore")
        highScore = count
        highScoreLabel.text = "High Score: \(highScore)"
        
    }
    func loadData()
    {
        let defaults = UserDefaults.standard
        highScore = defaults.integer(forKey: "highScore")
        highScoreLabel.text = "High Score: \(highScore)"
    }


    @IBAction func buttonTapped(_ sender: UIButton)
    {
        
        if timer.isValid == false
        {
            startTimer()
            
        }
        else {
            count += 1
            scoreLabel.text = "Score: \(count)"
        }
        
        
    }
    
    
    var timer = Timer()
    var time = 5
    
    func startTimer()
    {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { timer in
            self.timerAction()
        })
    }
    
    func stopTimer()
    {
        timer.invalidate()
    }
    
    func timerAction()
    {
        time -= 1
        timerLabel.text = "\(time)"
        
        if time <= 0
        {
            stopTimer()
            time = 5
            
            // end of the game. Display alert that shows our score and resets count
            if count > highScore
            {
                saveData()
            }
            endOfGameAlert()
        }
    }
    
    func endOfGameAlert()
    {
        let alert = UIAlertController(title: "GameOver", message: "Your Score: \(count)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { action in
            self.count = 0
            self.scoreLabel.text = "Score: \(0)"
            self.timerLabel.text = "\(self.time)"
            
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        

        
        
    }
    
    
    
    
    
    
    
}

