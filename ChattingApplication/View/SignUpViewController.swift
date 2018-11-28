//
//  SignUpViewController.swift
//  ChattingApplication
//
//  Created by krishna gunjal on 25/11/18.
//  Copyright © 2018 krishna gunjal. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class SignUpViewController: UIViewController {

    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailIdTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBAction func signUpClicked(_ sender: Any) {
        let userName = usernameTxt.text
        let password = passwordTxt.text
        let email = emailIdTxt.text
        if(email != nil) && (password != nil) {
            Auth.auth().createUser(withEmail: email!, password: password!, completion: { (result, error) in
                print(result as Any)
                if error != nil{
                    print(error)
                    return
                }
                else{
                    let ref = Database.database().reference()
                    let userData = ["email":email,"userName":userName]
                    let user = Auth.auth().currentUser
                    
                ref.child("users").child((user?.uid)!).setValue(userData)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "activeConversation")as! ActiveConversationTableViewController
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
                
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
