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
    
    
    var posts = [Post]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPosts()
    }
    
    func loadPosts(){
        let dataBaseRef =   Database.database().reference().child("posts")
        _ = dataBaseRef.observe(.childAdded) { (snapShot : DataSnapshot) in
            
            if  let dict = snapShot.value as? [String : Any] {
                let caption = dict["caption"] as? String
                let photoURL = dict["photoURL"] as! String
                
                let post = Post(captionText: caption ?? "", photoURLString: photoURL)
                self.posts.append(post)
                DispatchQueue.main.async {
                      self.tableView.reloadData()
                }
             
            }
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
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.caption
        return cell
    }
    
    
}
