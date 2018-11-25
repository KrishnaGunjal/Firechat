//
//  SignInViewController.swift
//  ChattingApplication
//
//  Created by krishna gunjal on 24/11/18.
//  Copyright © 2018 krishna gunjal. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class SignInViewController: UIViewController {
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBAction func signInClicked(_ sender: Any) {
        let email = emailTxt.text
        let password = passwordTxt.text
        if (email != nil) && (password != nil) {
            Auth.auth().signIn(withEmail: email!, password: password!, completion: { (result,error) in
                if error != nil{
                    print("Sign in failed")
                }
                else{
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "activeConversation")as! ActiveConversationViewController
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.backBarButtonItem?.title = ""
          navigationController?.navigationBar.barTintColor = UIColor.init(displayP3Red: 0/255, green: 0/255, blue: 255/255, alpha: 1.0)
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
