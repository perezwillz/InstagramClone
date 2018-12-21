//
//  AuthService.swift
//  InsagramCloneApp
//
//  Created by Perez Willie Nwobu on 12/19/18.
//  Copyright © 2018 Perez Willie Nwobu. All rights reserved.
//
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Foundation
class AuthService {
    
    static  func SignIn(email: String, password : String,   onSucess :  @escaping () -> Void, onError : @escaping (_ errorMessage : String?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            
            if error != nil {
                onError(error?.localizedDescription)
              
                return
            }
            onSucess()
        }}
    
    static  func SignUp(userName : String , email: String, password : String,  profileImage : UIImage? ,onSucess :  @escaping () -> Void, onError : @escaping (_ errorMessage : String?) -> Void){
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult : AuthDataResult?, error : Error?) in
            if error != nil {
                onError(error?.localizedDescription)
                return
            }
            
            //UserID
            let userID = authResult?.user.uid
            guard let uid = userID else {return}
            
            //FirebaseStorage
            //Saving Image
            let storageRef = Storage.storage().reference(forURL : "gs://instagramclone-7e77c.appspot.com")
            let imageRefence = storageRef.child("profile_image")
            
            let newImageReference = imageRefence.child(uid)
            guard let userProfileImage = profileImage else {return}
            guard   let imageData = userProfileImage.jpegData(compressionQuality: 0.1) else { print("error converting mage to Jpeg"); return}
            newImageReference.putData(imageData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    return
                }
                
                newImageReference.downloadURL(completion: { (url, error) in
                    guard let downloadURL = url else {
                        return
                    }
                    let profileUrlString = downloadURL.absoluteString
                    
                   self.setUsersInfo(profileURL: profileUrlString, username: userName, email: email, uid: uid)
                   
                })})
        }}
   static func setUsersInfo(profileURL : String, username : String, email : String, uid : String){
        let ref = Database.database().reference()
        let userReference = ref.child("users")
        let newUserReference = userReference.child(uid)
        newUserReference.setValue(["username " : username, "email " : email, "profilrURL " : profileURL])
        
    }

}
