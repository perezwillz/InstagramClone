//
//  AuthService.swift
//  InsagramCloneApp
//
//  Created by Perez Willie Nwobu on 12/19/18.
//  Copyright © 2018 Perez Willie Nwobu. All rights reserved.
//
import FirebaseAuth
import Foundation
class AuthService {
    
    static  func SignIn(email: String, password : String,   onSucess :  @escaping () -> Void){
        
    Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
    
    if error != nil {
    print(error!.localizedDescription)
    return
    }
    onSucess()
    }
    }
}
