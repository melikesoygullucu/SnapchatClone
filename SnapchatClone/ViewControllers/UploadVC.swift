//
//  UploadVC.swift
//  SnapchatClone
//
//  Created by Melike Soygüllücü on 30.07.2024.
//

import UIKit

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var uploadImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        uploadImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        uploadImageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func choosePhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @IBAction func uploadButton(_ sender: Any) {
    }
    
}
