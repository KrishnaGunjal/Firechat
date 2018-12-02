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
    var loader : UIActivityIndicatorView!
    
    @IBAction func signInClicked(_ sender: Any) {
        let email = emailTxt.text
        let password = passwordTxt.text
        self.displayActivityIndicatorView()
        if (email != nil) && (password != nil) {
            Auth.auth().signIn(withEmail: email!, password: password!, completion: { (result,error) in
                if error != nil{
                    print("Sign in failed")
                }
                else{
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "activeConversation")as! ActiveConversationTableViewController
                    self.navigationController?.pushViewController(viewController, animated: true)
               self.hideActivityIndicatorView()
                }
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.backBarButtonItem?.title = ""
          navigationController?.navigationBar.barTintColor = UIColor.init(displayP3Red: 0/255, green: 0/255, blue: 255/255, alpha: 1.0)
        loader = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loader.center = view.center
        loader.isHidden = true
        self.view.addSubview(loader)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
