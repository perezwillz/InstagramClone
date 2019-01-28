//
//  HomeViewController.swift
//  InsagramCloneApp
//
//  Created by Perez Willie Nwobu on 12/2/18.
//  Copyright © 2018 Perez Willie Nwobu. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPosts()
    }
    
    func loadPosts(){
    let dataBaseRef =   Database.database().reference().child("posts")
        let childAddedObserver = dataBaseRef.observe(.childAdded) { (snapShot : DataSnapshot) in
            //grabs all data, included new added child events
            //eachPost wiill be retrieved one by one into an optional dictionary
            print(snapShot.value)
           
        }
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

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    
}
