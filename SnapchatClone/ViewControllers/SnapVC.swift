//
//  SnapVC.swift
//  SnapchatClone
//
//  Created by Melike Soygüllücü on 30.07.2024.
//

import UIKit
import ImageSlideshow

class SnapVC: UIViewController {

    
    @IBOutlet weak var timeLabel: UILabel!
    
    var selectedSnap : Snap?
    var inputArray = [KingfisherSource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let snap = selectedSnap {
            timeLabel.text = "Time Left : \(snap.timeDifference)"
            
            for imageURL in snap.imageURLArray {
                inputArray.append(KingfisherSource(urlString: imageURL)!)
            }
            
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.9))
            
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = .lightGray
            pageIndicator.pageIndicatorTintColor = .black
            imageSlideShow.pageIndicator = pageIndicator
            
            imageSlideShow.backgroundColor = .white
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputArray)
            self.view.addSubview(imageSlideShow)
            
            self.view.bringSubviewToFront(timeLabel)
            
        }

    }

}
