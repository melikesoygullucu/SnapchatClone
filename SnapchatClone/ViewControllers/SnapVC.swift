//
//  SnapVC.swift
//  SnapchatClone
//
//  Created by Melike Soygüllücü on 30.07.2024.
//

import UIKit

class SnapVC: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    var selectedSnap : Snap?
    var remainingTime : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
            timeLabel.text = "Time Left: \(remainingTime) "
        
        // Do any additional setup after loading the view.
    }

}
