//
//  navScreenViewController.swift
//  Innovation Fest 2018
//
//  Created by Taha Mahmut Yazici on 14/01/2018.
//  Copyright © 2018 TH Productions. All rights reserved.
//

import UIKit

class navScreenVC: UIViewController {
    
    @IBOutlet weak var topCard: UIView!
    @IBOutlet weak var bottomCard: UIView!
    @IBOutlet weak var leadingShit: NSLayoutConstraint!
    
    var divisor: CGFloat!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        divisor = (view.frame.width / 2) / 0.61
    }

    // Navigation to Project List
    @IBAction func panTopCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        
        let scale = min(100 / abs(xFromCenter), 1)
        
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / divisor).scaledBy(x: scale, y: scale)
        card.center = CGPoint(x: (sender.view?.center.x)! + point.x, y: card.center.y)
        sender.setTranslation(CGPoint.zero, in: sender.view)
        
        if sender.state == UIGestureRecognizerState.ended {
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                })
                
                if card.center.x < 5 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4 ) {
                        UIView.animate(withDuration: 0.2, animations: { self.resetTopCard() })
                        self.performSegue(withIdentifier: "ShowList", sender:self)
                    }
                }
                
                return
            } else if card.center.x > view.frame.width - 75 {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
                })
                
                if card.center.x > view.frame.width - 5 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4 ) {
                        UIView.animate(withDuration: 0.2, animations: { self.resetTopCard() })
                        self.performSegue(withIdentifier: "ShowList", sender:self)
                    }
                    
                }
                
                return
            }
            
            UIView.animate(withDuration: 0.2, animations: { self.resetTopCard() })
        }
    }
    
    // This will be navigation to the Floor Map when I receive the map layout from Rehan
    @IBAction func panBottonCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        
        let scale = min(100 / abs(xFromCenter), 1)
        
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / divisor).scaledBy(x: scale, y: scale)
        card.center = CGPoint(x: (sender.view?.center.x)! + point.x, y: card.center.y)
        sender.setTranslation(CGPoint.zero, in: sender.view)
        
        if sender.state == UIGestureRecognizerState.ended {
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                })
                
                // if card.center.x < 05 { performSegue(withIdentifier: "ShowList", sender: self) }
                
                return
            } else if card.center.x > view.frame.width - 75 {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
                })
                
                // if card.center.x < 05 { performSegue(withIdentifier: "ShowList", sender: self) }
                
                return
            }
            
            UIView.animate(withDuration: 0.2, animations: { self.resetBottomCard() })
        }
    }
    
    func resetTopCard(){
        self.topCard.center.y = 257
        self.topCard.center.x = self.view.center.x
        self.topCard.transform = .identity
        self.topCard.alpha = 1
    }
    
    func resetBottomCard(){
        self.bottomCard.center.y = 565
        self.bottomCard.center.x = self.view.center.x
        self.bottomCard.transform = .identity
        self.bottomCard.alpha = 1
    }
}

