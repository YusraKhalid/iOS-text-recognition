//
//  Authentication.swift
//  ios-text-recognition
//
//  Created by Yusra Khalid on 3/31/18.
//  Copyright © 2018 Yusra Khalid. All rights reserved.
//

import UIKit

class Authentication : UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login() {
        print("check")
        guard let username = userName.text else {
            return
        }
        guard let password = password.text else {
            return
        }
   
            print(username, password)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // construct here
    }
}
