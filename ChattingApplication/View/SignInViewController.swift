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
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.hidesBarsOnTap = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        self.navigationItem.hidesBackButton = true
//        self.navigationItem.backBarButtonItem?.title = ""
//        navigationController?.navigationBar.barTintColor = UIColor.init(displayP3Red: 0/255, green: 128/255, blue: 0/255, alpha: 1.0)
        loader = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loader.center = view.center
        loader.isHidden = true
        self.view.addSubview(loader)
    }
    @IBAction func signInClicked(_ sender: Any) {
        let email = emailTxt.text
        let password = passwordTxt.text
        self.displayActivityIndicatorView()
        if (email != nil) && (password != nil) {
            Auth.auth().signIn(withEmail: email!, password: password!, completion: { (result,error) in
                if error != nil{
                    self.showAlert(title: "Error", message: (error?.localizedDescription)!)
                     self.hideActivityIndicatorView()
                }
                else{
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "activeConversation")as! ActiveConversationTableViewController
                    self.navigationController?.pushViewController(viewController, animated: true)
               self.hideActivityIndicatorView()
                }
            })
        }
    }
    
    func showAlert(title : String, message : String, action : String = "OK"){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: action, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
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
