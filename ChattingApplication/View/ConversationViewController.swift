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
    var keyArray = [conversationKeys]()
    
    @IBOutlet weak var msgTxt: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
                let keyObj = conversationKeys()
                
                msgObj.toId = toId
                msgObj.fromId = fromId
                msgObj.text = text
               keyObj.messageKey = item.key
                self.msgArray.append(msgObj)
                
                let user = Auth.auth().currentUser
                let ref = Database.database().reference().child("senderMessages").child((user?.uid)!)
                ref.observe(.value) { (snapshot) in
                    guard let senderSnapshot = snapshot.children.allObjects as? [DataSnapshot] else
                    {return}
                    for item in senderSnapshot{
                        keyObj.senderKey  = item.childSnapshot(forPath: "key").value as! String
                    }
                    
                }
                
                let receiverRef = Database.database().reference().child("recieverMessages").child((self.userData.userId))
                receiverRef.observe(.value) { (snapshot) in
                    guard let senderSnapshot = snapshot.children.allObjects as? [DataSnapshot] else
                    {return}
                    for item in senderSnapshot{
                        keyObj.receiverKey = item.childSnapshot(forPath: "key").value as! String
                    }
                    
                }
                 self.keyArray.append(keyObj)
                DispatchQueue.main.async() {
                    self.tableView.reloadData()
                }
            }
        }
    }
 
    @IBAction func sendMsgClicked(_ sender: Any) {
        let message = msgTxt.text
        if msgTxt.text == "" {
            let alert = UIAlertController(title: "Warning", message: "You cannnot sent empty message", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else{
        let ref = Database.database().reference().child("messages")
        let user = Auth.auth().currentUser
        let fromId = (user?.uid)!
        let childRef = ref.childByAutoId()
        let msg = ["text":message,"toId":userData.userId,"fromId":fromId]
        childRef.setValue(msg)
        
        let userMsgRef = Database.database().reference().child("senderMessages").child(fromId)
        let msgId = childRef.key
       // userMsgRef.setValue(msgId)
        let conversation = ["key":msgId,"message":message]
        userMsgRef.childByAutoId().setValue(conversation)
        
        let recieverMsgRef = Database.database().reference().child("recieverMessages").child(userData.userId)
        let rcvId = childRef.key
        // userMsgRef.setValue(msgId)
        let rcvConversation = ["key":rcvId,"message":message]
        recieverMsgRef.childByAutoId().setValue(rcvConversation)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.msgArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msgObj = self.msgArray[indexPath.row]
        
        if ( userData.userId == msgObj.fromId) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "messageFromMe")as! MessageFromMeCell
            cell.msgFromMe.text = msgObj.text
            return cell
        }
      else //(keyObj.messageKey == keyObj.receiverKey)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "messageFromYou")as! MessagesCustomCellTableViewCell
            cell.msgFromYou.text = msgObj.text
            return cell
        }
        /*else{
             let cell1 = tableView.dequeueReusableCell(withIdentifier: "messageFromMe")as! MessageFromMeCell
            cell1.msgFromMe.text = ""
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "messageFromYou")as! MessagesCustomCellTableViewCell
            cell2.msgFromYou.text = ""
            return (cell1)
        }*/
    }
}
