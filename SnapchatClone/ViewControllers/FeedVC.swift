//
//  FeedVC.swift
//  SnapchatClone
//
//  Created by Melike Soygüllücü on 30.07.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let firestoreDatabase = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserInfo()
        tableView.delegate = self
        tableView.dataSource = self
        
        getSnapsFromFirebase()

        // Do any additional setup after loading the view.
    }
    
    func getSnapsFromFirebase() {
        firestoreDatabase.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
            } else {
                if snapshot?.isEmpty != false && snapshot != nil {
                    for document in snapshot!.documents {
                        
                    }
                }
            }
        }
    }
    
    
    func getUserInfo() {
        firestoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser?.email!).getDocuments { snapshot, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        if let username = document.get("username") as? String {
                            UserModel.sharedUserInfo.email = Auth.auth().currentUser!.email!
                            UserModel.sharedUserInfo.username = username
                        }
                    }
                }
            }
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.feedUserNameLabel.text = "test"
        return cell
    }
    
}
