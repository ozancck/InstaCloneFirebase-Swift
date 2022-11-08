//
//  FeedViewController.swift
//  InstaCloneFirebase
//
//  Created by Ozan Çiçek on 31.10.2022.
//

import UIKit
import FirebaseFirestore
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userArray = [String]()
    var commentArray = [String]()
    var likeArray = [Int]()
    var imageArray = [String]()
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirestore()
        
    }
    
    
    func getDataFromFirestore(){
        
        let fireStoreDataBase = Firestore.firestore()
        
        fireStoreDataBase.collection("Posts").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                
                self.userArray.removeAll(keepingCapacity: false)
                self.commentArray.removeAll(keepingCapacity: false)
                self.likeArray.removeAll(keepingCapacity: false)
                self.imageArray.removeAll(keepingCapacity: false)
                
                if snapshot?.isEmpty != true && snapshot != nil{
                    for document in snapshot!.documents{
                        
                        if let postedBy =  document.get("postedBy") as? String {
                            self.userArray.append(postedBy)
                        }
                        if let comment = document.get("postComment") as? String {
                            self.commentArray.append(comment)
                        }
                        if let like = document.get("likes") as? Int {
                            self.likeArray.append(like)
                        }
                        if let imageUrl = document.get("imageURL") as? String {
                            self.imageArray.append(imageUrl)
                        }
                    }
                    
                
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        
        cell.userEmailLabel.text = userArray[indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string: self.imageArray[indexPath.row]))
        cell.commentLabel.text = commentArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        
        return cell
    }
    
    
}
