//
//  HomeViewController.swift
//  RecipeApp
//
//  Created by Angela Degryse on 29/10/2022.
//

import UIKit

class HomeViewController: UIViewController {
    let apikey="14dd3278bfce4867b103a17c66bf891e"
    
    @IBOutlet weak var randomTriviaLabel: UILabel!
    
    @IBOutlet weak var randomRecipeTitle: UILabel!
    @IBOutlet weak var randomRecipeImage: UIImageView!
    
    
    
    override func viewDidLoad() {
//        let imageTapGesture = UITapGestureRecognizer(target: self, action: Selector("profileTapped"))
//        profileIcon.addGestureRecognizer(imageTapGesture)
        
        fetchRandomTrivia()
        fetchRandomRecipe()
        
        super.viewDidLoad()
        
    }
    func profileTapped(){
        
    }
    
    func fetchRandomTrivia(){
        let url = URL(string: "https://api.spoonacular.com/food/trivia/random?apiKey=\(apikey)")!
        
        URLSession.shared.fetchData(for: url) {(result: Result<Trivia, Error>) in
            switch result {
            case .success(let joke):
                DispatchQueue.main.async { [self] in
                    randomTriviaLabel.text = joke.text
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchRandomRecipe(){
        let url = URL(string: "https://api.spoonacular.com/recipes/random?apiKey=\(apikey)")!
        
        URLSession.shared.fetchData(for: url) {(result: Result<RecipeResult, Error>) in
            switch result {
            case .success(let result):
                let url = URL(string: result.recipes[0].image)!
                
                DispatchQueue.global().async {
                    // Fetch Image Data
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {[self] in
                            // Create Image and Update Image View
                            randomRecipeImage.image = UIImage(data: data)
                            randomRecipeTitle.text = result.recipes[0].title
                            
                        }
                    }
                    
                    
                }
                
            case .failure(let error):
                print(error)
            }
        }
        randomRecipeImage.layer.shadowColor = UIColor.black.cgColor
        randomRecipeImage.layer.shadowRadius = 3.0
        randomRecipeImage.layer.shadowOpacity = 1.0
        randomRecipeImage.layer.shadowOffset = CGSize(width: 4, height: 4)
        randomRecipeImage.layer.masksToBounds = false
    }
    
    
}
