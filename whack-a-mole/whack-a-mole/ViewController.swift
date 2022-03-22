//
//  ViewController.swift
//  whack-a-mole
//
//  Created by 이정우 on 2022/03/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstMoleView : UIView!
    @IBOutlet weak var secondMoleView : UIView!
    @IBOutlet weak var thirdMoleView : UIView!

    @IBOutlet weak var startButton : UIButton!
    
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var timerLabel : UILabel!
    
    var score = 0
    
    var gameTimer : Timer?
    var gameTimerTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMoleHole(moleHoleView: firstMoleView)
        setMoleHole(moleHoleView: secondMoleView)
        setMoleHole(moleHoleView: thirdMoleView)
        
    }
    
    func setMoleHole(moleHoleView : UIView){
        let holeView = holeView()
        holeView.frame = CGRect(x: 0, y: 150, width: moleHoleView.frame.width, height: moleHoleView.frame.height-150)
        holeView.backgroundColor = .clear
        moleHoleView.addSubview(holeView)
        
        let improveView = improveView()
        improveView.frame = CGRect(x: 21.3, y: 180, width: moleHoleView.frame.width-42, height: moleHoleView.frame.height-180)
        improveView.backgroundColor = .clear
        moleHoleView.addSubview(improveView)
        
        let moleView = moleView()
        moleView.frame = CGRect(x: 0, y: 0, width: moleHoleView.frame.width, height: moleHoleView.frame.height)
        moleView.backgroundColor = .clear
        moleHoleView.addSubview(moleView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let hammerImageView = UIImageView()
        hammerImageView.image = UIImage(named: "hammer")?.withHorizontallyFlippedOrientation()
        hammerImageView.frame = CGRect(x: (touches.first?.location(in: self.view).x)!-10, y: (touches.first?.location(in: self.view).y)!-60, width: 100, height: 100)
        self.view.addSubview(hammerImageView)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            hammerImageView.removeFromSuperview()
        }
    }
    
    @objc func tapMoleHoleView(_ sender : UITapGestureRecognizer){
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    
    func randomStandingMole(){
        var randomTime : TimeInterval{
            return TimeInterval.random(in: 0.6...4)
        }
        let timer = Timer.scheduledTimer(withTimeInterval: randomTime, repeats: false, block: { timer in
            let randomViewNumber = Int.random(in: 1...3)
            if randomViewNumber == 1{
                self.standingMole(moleHoleView: self.firstMoleView)
            }else if randomViewNumber == 2{
                self.standingMole(moleHoleView: self.secondMoleView)
            }else if randomViewNumber == 3{
                self.standingMole(moleHoleView: self.thirdMoleView)
            }
            if self.gameTimerTime > 0 {
                self.randomStandingMole()
            }else{
                
            }
        })
    }
    
    func standingMole(moleHoleView : UIView){
        let standMoleView = standMoleView()
        standMoleView.frame = CGRect(x: 0, y: 0, width: moleHoleView.frame.width, height: moleHoleView.frame.height)
        standMoleView.backgroundColor = .clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapMoleHoleView(_:)))
        standMoleView.addGestureRecognizer(tapGesture)
        moleHoleView.addSubview(standMoleView)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            standMoleView.removeFromSuperview()
        }
    }
    
    @IBAction func touchStartButton(){
        if gameTimer != nil && gameTimer!.isValid {
                gameTimer!.invalidate()
        }
        gameTimerTime = 20
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
        randomStandingMole()
        startButton.removeFromSuperview()
    }
    
    @objc func timerCallback(){
        if gameTimerTime != 0 {
            timerLabel.text = "\(gameTimerTime)"
        }else{
            timerLabel.text = ""
            gameTimer?.invalidate()
            gameTimer = nil
        }
        gameTimerTime-=1
    }

}

class holeView : UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.black.setFill()
        path.fill()
    }
}

class improveView : UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.brown.setFill()
        path.fill()
    }
}

class moleView : UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(arcCenter: CGPoint(x: self.frame.midX, y: self.frame.maxY), radius: 60, startAngle: (.pi * 188) / 180, endAngle: (.pi * 352) / 180, clockwise: true)
        UIColor.brown.setFill()
        path.fill()
        path.lineWidth = 3
        path.stroke()
    }
}

class standMoleView : UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 21.3, y: 190))
        path.addLine(to: CGPoint(x: 21.3, y: 80))
        path.addCurve(to: CGPoint(x: 139.3, y: 80), controlPoint1: CGPoint(x: 21.3, y: 0), controlPoint2: CGPoint(x: 139.3, y: 0))
        path.addLine(to: CGPoint(x: 139.3, y: 190))
        UIColor.brown.setFill()
        path.fill()
        path.lineWidth = 3
        path.stroke()
    }
}




