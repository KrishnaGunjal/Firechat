//
//  ActiveConversationTableViewController.swift
//  ChattingApplication
//
//  Created by krishna gunjal on 26/11/18.
//  Copyright © 2018 krishna gunjal. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class ActiveConversationTableViewController: UITableViewController {
    var userArray = [user]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
        self.tableView.reloadData()
 }
    @IBAction func logoutClicked(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
        } catch let signOutError as NSError {
            print(signOutError)
        }
        print("Logout Done")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignInViewController")as! SignInViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchUsers(){
        let ref = Database.database().reference().child("users")
        ref.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as?[DataSnapshot] else {return}
            for item in userSnapshot{
                let name = item.childSnapshot(forPath: "userName").value as! String
                print(name)
                let mail = item.childSnapshot(forPath: "email").value as! String
                let userObj = user()
                userObj.userName = name
                userObj.email = mail
                userObj.userId = item.key
                self.userArray.append(userObj)
                DispatchQueue.main.async() {
                    self.tableView.reloadData()
                }
            }
        }
    }
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let user = self.userArray[indexPath.row]
        print(user.userName)
        cell.textLabel?.text = user.userName
        cell.detailTextLabel?.text = user.email
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let conversation = storyboard.instantiateViewController(withIdentifier: "conversationsVC")as! ConversationViewController
        conversation.userData = self.userArray[indexPath.row]
        self.navigationController?.pushViewController(conversation, animated: true)
    }
}
