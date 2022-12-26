//
//  ViewController.swift
//  RecipeApp
//
//  Created by Angela Degryse on 28/10/2022.
//

import UIKit
import Auth0

var loggedInUser  = User.empty

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func LogInButtonClicked(_ sender: UIButton) {
        Auth0
            .webAuth()
            .start { result in
                switch result {
                case .success(let credentials):
                    loggedInUser = User.from(credentials.idToken)
                    print(loggedInUser.name)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let TabBarController = storyboard.instantiateViewController(identifier: "TabBarController")

                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController)
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }


    }
}

