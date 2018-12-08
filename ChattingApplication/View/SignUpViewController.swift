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

    var loader : UIActivityIndicatorView!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailIdTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loader.center = view.center
        loader.isHidden = true
        self.view.addSubview(loader)
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        let userName = usernameTxt.text
        let password = passwordTxt.text
        let email = emailIdTxt.text
        self.displayActivityIndicatorView()
        if(email != nil) && (password != nil) {
            Auth.auth().createUser(withEmail: email!, password: password!, completion: { (result, error) in
                print(result as Any)
                if error != nil{
                    print(error)
                }
                else{
                    let ref = Database.database().reference()
                    let userData = ["email":email,"userName":userName]
                    let user = Auth.auth().currentUser
                    
                ref.child("users").child((user?.uid)!).setValue(userData)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "activeConversation")as! ActiveConversationTableViewController
                    self.navigationController?.pushViewController(viewController, animated: true)
                    self.hideActivityIndicatorView()
                }
                
            })
        }
    }
    
    func displayActivityIndicatorView(){
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.view.bringSubview(toFront: self.loader)
        self.loader.isHidden = false
        self.loader.startAnimating()
    }
    
    func hideActivityIndicatorView(){
        if !self.loader.isHidden{
            DispatchQueue.main.async {
                UIApplication.shared.endIgnoringInteractionEvents()
                self.loader.stopAnimating()
                self.loader.isHidden = true
            }
        }
}
}
