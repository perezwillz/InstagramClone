//
//  SignUPViewController.swift
//  InsagramCloneApp
//
//  Created by Perez Willie Nwobu on 12/2/18.
//  Copyright © 2018 Perez Willie Nwobu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage



class SignUPViewController: UIViewController {
    var selectedImage : UIImage?
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        addGestures()
        handleTextField()
        profileImage.image?.accessibilityIdentifier = AccesbilityIdentifiers.oldImage.rawValue
        
    }
    
    func setUpViews(){
        //userName
        userNameTextField.backgroundColor = UIColor.clear
        guard let userNamePlaceHolder = userNameTextField.placeholder else {return}
        userNameTextField.tintColor = .white
        userNameTextField.textColor = .white
        let userNameBottomLayer = CALayer()
        userNameBottomLayer.frame = CGRect(x: 0, y: 32, width: view.frame.width - 30, height: 0.6)
        userNameBottomLayer.backgroundColor = UIColor(red: 50/225, green: 50/255, blue: 25/255, alpha: 1).cgColor
        userNameTextField.layer.addSublayer(userNameBottomLayer)
        userNameTextField.attributedPlaceholder = NSAttributedString(string: userNamePlaceHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor(white: 1.0, alpha: 0.6)])
        
        //EmailtextField
        emailTextField.backgroundColor = UIColor.clear
        guard let placeHolder = emailTextField.placeholder else {return}
        emailTextField.tintColor = .white
        emailTextField.textColor = .white
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: 32, width: view.frame.width - 30, height: 0.6)
        bottomLayer.backgroundColor = UIColor(red: 50/225, green: 50/255, blue: 25/255, alpha: 1).cgColor
        emailTextField.layer.addSublayer(bottomLayer)
        emailTextField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor(white: 1.0, alpha: 0.6)])
        
        
        //Password
        passwordTextField.backgroundColor = UIColor.clear
        guard let passwordPlaceHolder = passwordTextField.placeholder else {return}
        passwordTextField.tintColor = .white
        passwordTextField.textColor = .white
        let passwordBottomLayer = CALayer()
        passwordBottomLayer.frame = CGRect(x: 0, y: 32, width: view.frame.width - 30, height: 0.6)
        passwordBottomLayer.backgroundColor = UIColor(red: 50/225, green: 50/255, blue: 25/255, alpha: 1).cgColor
        passwordTextField.layer.addSublayer(passwordBottomLayer)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordPlaceHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor(white: 1.0, alpha: 0.6)])
        
      
        profileImage.layer.cornerRadius = 75
        profileImage.clipsToBounds = true
    }
    
    private func addGestures(){
        profileImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUPViewController.selectProfileImage))
        profileImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func selectProfileImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated:  true, completion: nil)
    }
    @IBAction func dismissView(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
   private func handleTextField(){
        userNameTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    
    @objc func textFieldDidChange(){
        guard let username = userNameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let  _ = profileImage.image,
            profileImage.image?.accessibilityIdentifier != "Old"
            else
        {
            //Fade sign up button text, Disable Buttn
            signUpButton.setTitleColor(UIColor.clear, for: .normal)
            signUpButton.isEnabled = false
            signUpButton.layer.cornerRadius = 0
            return
        }
        //Everything ok: Highlight sign up button
        signUpButton.isEnabled = true
        signUpButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        signUpButton.layer.cornerRadius = 5
    }
    
    
    @IBAction func signUpBtnTouchUpInside(_ sender: Any) {
        guard let username = userNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else {return}
        Auth.auth().createUser(withEmail: email, password: password) { (authResult : AuthDataResult?, error : Error?) in
            
            if error != nil {
                print(error!.localizedDescription)
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
            guard let userProfileImage = self.selectedImage else {return}
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
                    setUsersInfo(profileURL: profileUrlString, username: username, email: email, uid: uid)
                      self.performSegue(withIdentifier: "SignUPToTabBar", sender: nil)
                })})
        }}}


func setUsersInfo(profileURL : String, username : String, email : String, uid : String){
    let ref = Database.database().reference()
    let userReference = ref.child("users")
    let newUserReference = userReference.child(uid)
    newUserReference.setValue(["username " : username, "email " : email, "profilrURL " : profileURL])
    
    
}

extension SignUPViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        selectedImage = image
        profileImage.image = image
        profileImage.image?.accessibilityIdentifier = AccesbilityIdentifiers.newImage.rawValue
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
