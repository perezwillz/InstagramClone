//
//  SignInViewController.swift
//  InsagramCloneApp
//
//  Created by Perez Willie Nwobu on 12/2/18.
//  Copyright © 2018 Perez Willie Nwobu. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPViews()
        handleTextField()
        
    }
    
    func automaticallySignUsersIn(){
        if Auth.auth().currentUser != nil {
           self.performSegue(withIdentifier: "SignInToTabBar", sender: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        automaticallySignUsersIn()
    }
    
    func setUPViews(){
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
        
        //PasswordTextField
        passwordTextField.backgroundColor = UIColor.clear
        guard let PasswordPlaceHolder = passwordTextField.placeholder else {return}
        passwordTextField.tintColor = .white
        passwordTextField.textColor = .white
        let passwordTextFieldbottomLayer = CALayer()
        passwordTextFieldbottomLayer.frame = CGRect(x: 0, y: 32, width: view.frame.width - 30, height: 0.6)
        passwordTextFieldbottomLayer.backgroundColor = UIColor(red: 50/225, green: 50/255, blue: 25/255, alpha: 1).cgColor
       passwordTextField.layer.addSublayer(passwordTextFieldbottomLayer)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: PasswordPlaceHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor(white: 1.0, alpha: 0.6)])
         signInButton.isEnabled = false
    }
    
    
    private func handleTextField(){
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(){
        guard
            let password = passwordTextField.text, !password.isEmpty,
            let email = emailTextField.text, !email.isEmpty
        
            else
        {
            //Fade sign up button text, Disable Buttn
            signInButton.setTitleColor(UIColor.clear, for: .normal)
           signInButton.isEnabled = false
            signInButton.layer.cornerRadius = 0
            return
        }
        //Everything ok: Highlight sign up button
        signInButton.isEnabled = true
        signInButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        signInButton.layer.cornerRadius = 5
    }


    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else
        {return}
        
        
        AuthService.SignIn(email: email, password: password, onSucess: { self.performSegue(withIdentifier: "SignInToTabBar", sender: nil)}, onError: { error in
            print(error!)
        })
        
             }
}
