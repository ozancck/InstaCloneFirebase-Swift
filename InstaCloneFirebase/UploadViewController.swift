//
//  UploadViewController.swift
//  InstaCloneFirebase
//
//  Created by Ozan Çiçek on 31.10.2022.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentText: UITextField!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    
    @objc func chooseImage(){
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
   
    @IBAction func actionButtonClicked(_ sender: Any) {
         
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        
        let mediaFolder = storageReferance.child("media")
        
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = "\(UUID().uuidString).jpg"
            
            let imageReferance = mediaFolder.child(uuid)
            
            imageReferance.putData(data) { metaData, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "error")
                }else{
                    imageReferance.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            print(imageUrl)
                            
                            
                            //DaraBase
                            
                            let firestoreDataBase = Firestore.firestore()
                            
                            var firestoreReferance : DocumentReference? = nil
                            
                            let firestorePost = ["imageURL" : imageUrl!, "postedBy": Auth.auth().currentUser!.email!, "postComment": self.commentText.text!, "date": "date",
                                                 "likes" : 0,] as [String: Any]
                            
                            firestoreReferance = firestoreDataBase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                                }
                            })
                            
                            
                            
                        }
                    }
                }
                
            }
            
        
        }
        
        
    }
    
    
}
