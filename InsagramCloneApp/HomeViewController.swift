//
//  HomeViewController.swift
//  InsagramCloneApp
//
//  Created by Perez Willie Nwobu on 12/2/18.
//  Copyright © 2018 Perez Willie Nwobu. All rights reserved.
//

import UIKit
import FirebaseAuth
class HomeViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
   
    @IBAction func logoutButtonPressed(_ sender: Any) {
       
        do {
     try  Auth.auth().signOut()
        } catch let logOutError {
            NSLog( "Error while trying to log out : \(logOutError.localizedDescription)")
        }
      
        
        let storyboard = UIStoryboard(name: "Start", bundle: nil)
      let SignInVC =   storyboard.instantiateViewController(withIdentifier: "SignInVC")
        self.present(SignInVC, animated: true, completion: nil)
    }
    
}
