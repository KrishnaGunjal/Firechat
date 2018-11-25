//
//  ViewController.swift
//  ChattingApplication
//
//  Created by krishna gunjal on 24/11/18.
//  Copyright © 2018 krishna gunjal. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.init(displayP3Red: 0/255, green: 0/255, blue: 255/255, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    override func viewDidAppear(_ animated: Bool) {
        let viewC : UIViewController!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if ( Auth.auth().currentUser != nil)
        {
             viewC = storyboard.instantiateViewController(withIdentifier: "activeConversation") as! ActiveConversationViewController
        }
        else
        {
            viewC = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        }
        self.navigationController?.pushViewController(viewC, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

