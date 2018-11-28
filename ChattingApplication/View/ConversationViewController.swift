//
//  ConversationViewController.swift
//  ChattingApplication
//
//  Created by krishna gunjal on 26/11/18.
//  Copyright © 2018 krishna gunjal. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class ConversationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var userData : user!
    var msgArray = [message]()

    @IBOutlet weak var msgTxt: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
     //   tableView.delegate = self
       // tableView.dataSource = self
        self.navigationItem.title = userData.userName
        loadMessages()
    }
    
    func loadMessages(){
        let ref = Database.database().reference().child("messages")
        ref.observe(.value) { (snapshot) in
            guard let msgSnapshot = snapshot.children.allObjects as?[DataSnapshot] else {return}
            for item in msgSnapshot{
                let text = item.childSnapshot(forPath: "text").value as! String
                print(text)
                let toId = item.childSnapshot(forPath: "toId").value as! String
                let fromId = item.childSnapshot(forPath: "toId").value as! String
                let msgObj = message()
                msgObj.toId = toId
                msgObj.fromId = fromId
                msgObj.text = text
                self.msgArray.append(msgObj)
                DispatchQueue.main.async() {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func sendMsgClicked(_ sender: Any) {
        let message = msgTxt.text
        let ref = Database.database().reference().child("messages")
        let user = Auth.auth().currentUser
        let fromId = (user?.uid)!
        let childRef = ref.childByAutoId()
        let msg = ["text":message,"toId":userData.userId,"fromId":fromId]
        childRef.setValue(msg)
        
       /* let userMsgRef = Database.database().reference().child("userMessages").child(fromId)
        let usrMsg = ["text":message,"toId":userData.userId]
        let msgId = childRef.key
        userMsgRef.setValue([msgId:1])*/
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.msgArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell")as! MessagesCustomCellTableViewCell
        let user = Auth.auth().currentUser
        
        let msgObject = msgArray[indexPath.row]
       
        var youMsg : String!
        var meMsg : String!
        
            if (self.userData.userId == msgObject.toId) && (msgObject.fromId == (user?.uid)!) {
            youMsg = msgObject.text
        }
            if ((user?.uid) == msgObject.fromId) && ((self.userData.userId == msgObject.toId)) {
            meMsg = msgObject.text
        }
        cell.msgFromYou.text = youMsg
        cell.msgFromMe.text = meMsg
         return cell
    }
}
