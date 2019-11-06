//
//  SignUpViewController.swift
//  HeartRate_DBTest01
//
//  Created by Roger Eduardo Vazquez Tuz on 11/4/19.
//  Copyright © 2019 Roger Eduardo Vazquez Tuz. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        
        let signUpManager = FirebaseAuthManager()
        if let email = emailTF.text, let password = passwordTF.text {
            signUpManager.createUser(email: email, password: password) {[weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if (success) {
                    message = "Usuario creado con éxito, bienvenido."
                    self.performSegue(withIdentifier: "showSignup", sender: self)
                } else {
                    message = "uh-oh hubo un error!."
                }
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                
                self.display(alertController: alertController)
            }
        }
        
        
        
    }
    
    func display(alertController: UIAlertController) {
          self.present(alertController, animated: true, completion: nil)
      }
    
    
    
}
