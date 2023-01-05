//
//  UserViewController.swift
//  RecipeApp
//
//  Created by Angela Degryse on 26/12/2022.
//

import UIKit
import Auth0
import JWTDecode

class UserViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = loggedInUser.name
        emailLabel.text = loggedInUser.email
        profilePicture.load(urlString: loggedInUser.picture)

    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                case .success:
                    print("Logged out")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let LoginController = storyboard.instantiateViewController(identifier: "LoginViewController")
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(LoginController, animated: true)
                    
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }
}

extension UIImageView {
    func load(urlString : String) {
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

