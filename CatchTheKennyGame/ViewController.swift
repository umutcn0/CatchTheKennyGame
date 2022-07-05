//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Umut Can on 7.06.2022.
//

import UIKit

class ViewController: UIViewController {
    var timer = Timer()
    var timer2 = Timer()
    var time = 0
    var score = 0
    var kennyArray = [UIImageView]()
    var highScore = 0
    

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        
        let savedScore = UserDefaults.standard.object(forKey: "highScore")
        
        if savedScore == nil {
            highScoreLabel.text = "High Score: 0"
        }
        if let newScore = savedScore as? Int  {
            highScoreLabel.text = "High Score: \(newScore)"
        }
        
        // Gesture Operations
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        

        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        time = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        timeLabel.text = "Time: \(time)"
        timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(visible), userInfo: nil, repeats: true)
        
        visible()
    }
    
    @objc func countdown() {
        time -= 1
        timeLabel.text = "Time: \(time)"
        
        if time == 0{
            timer.invalidate()
            timer2.invalidate()
            
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "High Score: \(highScore)"
                UserDefaults.standard.set(highScore, forKey: "highScore")
                
            }
            
             // Alert
            let alert = UIAlertController(title: "Time's Up !", message: "Game has finished", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let restartButton = UIAlertAction(title: "Restart", style: UIAlertAction.Style.default) { UIAlertAction in
                //Restart Actions
                self.time = 10
                self.timeLabel.text = "Time: \(self.time)"
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
                self.timer2 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.visible), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(restartButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }

    @objc func visible(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        
        let rand_number = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[rand_number].isHidden = false
    }

}

