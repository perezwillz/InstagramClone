//
//  SignUPViewController.swift
//  InsagramCloneApp
//
//  Created by Perez Willie Nwobu on 12/2/18.
//  Copyright © 2018 Perez Willie Nwobu. All rights reserved.
//

import UIKit
import FirebaseAuth



class SignUPViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
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
        
        //Image
        profileImage.layer.cornerRadius = 75
        profileImage.clipsToBounds = true
    }
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func signUpBtnTouchUpInside(_ sender: Any) {
//        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
//            // ...
//            guard let user = authResult?.user else { return }
//        }
        
     
        
        Auth.auth().createUser(withEmail: "User1@gmail.com", password: "123456") { (authResult : AuthDataResult?, error : Error?) in
            
            if error != nil {
                print(error?.localizedDescription)
            return
        }
        
            print(authResult?.user)
    }
    }
}
