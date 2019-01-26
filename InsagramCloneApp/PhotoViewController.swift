//
//  PhotoViewController.swift
//  InsagramCloneApp
//
//  Created by Perez Willie Nwobu on 12/2/18.
//  Copyright © 2018 Perez Willie Nwobu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var shareButtn: UIButton!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var photo: UIImageView!
    var selectedImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestures()
        photo.image?.accessibilityIdentifier = AccesbilityIdentifiers.oldImage.rawValue
    }
    
    @IBAction func shareButtnTapped(_ sender: Any) {
        
        guard let postImage = selectedImage else { ProgressHUD.showError("Please select an Image to Post"); return}
        
        ProgressHUD.show("Posting Photo", interaction: false)
        guard  let imageData = postImage.jpegData(compressionQuality: 0.1) else { print("error converting mage to Jpeg"); return}
        
        //Saving Image
        let storageRef = Storage.storage().reference(forURL : "gs://instagramclone-7e77c.appspot.com")
        let imageRefence = storageRef.child("posts")
        let photoIDString = NSUUID().uuidString
        let newImageReference = imageRefence.child(photoIDString)
        
        newImageReference.putData(imageData, metadata: nil, completion: { (metadata, error) in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
                return
            }
            
            newImageReference.downloadURL(completion: { (url, error) in
                guard let downloadURL = url else {
                    return
                }
                let photoUrlString = downloadURL.absoluteString
               self.sendDataToDatabase(photoURLString: photoUrlString)
            })})
    }
    
    func sendDataToDatabase(photoURLString : String){
        let ref = Database.database().reference()
        let postsReference = ref.child("posts")
        let newPostID = postsReference.childByAutoId().key
        let newPostReference = postsReference.child(newPostID)
       
        
        //newPostReference.setValue(["photoURL" : photoURLString])
        newPostReference.setValue(["photoURL" : photoURLString]) { (error, ref) in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Sucess")
        }
    }
    
    //gestureRecognizer
    private func addGestures(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPostImage))
        photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true
    }
    
    
    @objc func handleSelectPostImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated:  true, completion: nil)
    }
    
}

extension PhotoViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        selectedImage = image
        photo.image = image
        photo.image?.accessibilityIdentifier = AccesbilityIdentifiers.newImage.rawValue
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
