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
    
    private var accesstoken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func LogInButtonClicked(_ sender: UIButton) {
        Auth0
            .webAuth()
            .start { result in
                switch result {
                case .success(let credentials):
                    self.accesstoken = credentials.idToken
                    loggedInUser = User.from(self.accesstoken)
                    print(loggedInUser.name)
                    Auth0
                       .authentication()
                       .userInfo(withAccessToken: credentials.accessToken)
                       .start { result in
                           switch result {
                           case .success(let user):
                               print("Obtained user: \(user)")
                           case .failure(let error):
                               print("Failed with: \(error)")
                           }
                       }
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let TabBarController = storyboard.instantiateViewController(identifier: "TabBarController")

                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController)
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
        print("hello")
        
    }
}

