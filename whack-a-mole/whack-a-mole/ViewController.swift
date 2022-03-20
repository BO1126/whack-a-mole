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

    override func viewDidLoad() {
        super.viewDidLoad()
        setMoleHole(moleHoleView: firstMoleView)
        setMoleHole(moleHoleView: secondMoleView)
        setMoleHole(moleHoleView: thirdMoleView)
        // Do any additional setup after loading the view.
    }
    
    func setMoleHole(moleHoleView : UIView){
        let holeView = holeView()
        holeView.frame = CGRect(x: 0, y: 150, width: moleHoleView.frame.width, height: moleHoleView.frame.height-150)
        holeView.backgroundColor = .clear
        moleHoleView.addSubview(holeView)
        
        let moleView = moleView()
        moleView.frame = CGRect(x: 0, y: 0, width: moleHoleView.frame.width, height: moleHoleView.frame.height)
        moleView.backgroundColor = .clear
        moleHoleView.addSubview(moleView)
        
        let improveView = improveView()
        improveView.frame = CGRect(x: 21.3, y: 180, width: moleHoleView.frame.width-42, height: moleHoleView.frame.height-180)
        improveView.backgroundColor = .clear
        moleHoleView.addSubview(improveView)
        
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
        path.stroke()
    }
}



