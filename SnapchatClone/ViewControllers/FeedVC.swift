//
//  FeedVC.swift
//  SnapchatClone
//
//  Created by Melike Soygüllücü on 30.07.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import SDWebImage

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let firestoreDatabase = Firestore.firestore()
    var snapArray = [Snap]()
    var chosenSnap : Snap?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getUserInfo()
        getSnapsFromFirebase()

        // Do any additional setup after loading the view.
    }
    
    func getSnapsFromFirebase() {
        firestoreDatabase.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    self.snapArray.removeAll(keepingCapacity: false)
                           
                    
                    for document in snapshot!.documents {
                        
                        let documentID = document.documentID
                        
                        if let username = document.get("owner") as? String {
                            if let imageURL = document.get("imageURL") as? [String] {
                                if let date = document.get("date") as? Timestamp {
                                    
                                    if let difference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour {
                                        if difference >= 24 {
                                            self.firestoreDatabase.collection("Snaps").document(documentID).delete { error in
                                               
                                            }
                                        }
                                        
                                        let snap = Snap(username: username, imageURLArray: imageURL, date: date.dateValue(), timeDifference: 24 - difference)
                                        self.snapArray.append(snap)
                                    }
                                    
                                    
                                    
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
               
            }
            
        }
    }
    
    
    func getUserInfo() {
        firestoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { snapshot, error in
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
        return snapArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.feedUserNameLabel.text = snapArray[indexPath.row].username
        cell.feedImageView.sd_setImage(with: URL(string: snapArray[indexPath.row].imageURLArray[0]))
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSnapVC" {
            let destinationVC = segue.destination as! SnapVC
            destinationVC.selectedSnap = chosenSnap
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSnap = self.snapArray[indexPath.row]
        performSegue(withIdentifier: "toSnapVC", sender: nil)
    }
}
