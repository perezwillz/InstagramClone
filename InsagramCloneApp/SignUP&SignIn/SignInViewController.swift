//
//  SignInViewController.swift
//  InsagramCloneApp
//
//  Created by Perez Willie Nwobu on 12/2/18.
//  Copyright © 2018 Perez Willie Nwobu. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
setUPViews()
        // Do any additional setup after loading the view.
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
        
        
    }

}
