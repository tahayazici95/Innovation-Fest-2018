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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Navigation to Project List
    @IBAction func panTopCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let initialPlace = card.center
        let point = sender.translation(in: view)
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        if card.center.x - initialPlace.x > 25 || initialPlace.x - card.center.x > 25 {
            performSegue(withIdentifier: "ShowList", sender: self)
        }
    }
    
    // This will be navigation to the Floor Map when I receive the map layout from Rehan
    @IBAction func panBottonCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
    }
}
