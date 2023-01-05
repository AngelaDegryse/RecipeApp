//
//  HomeViewController.swift
//  RecipeApp
//
//  Created by Angela Degryse on 29/10/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var randomTriviaLabel: UILabel!
    
    @IBOutlet weak var likesButton: UIButton!
    @IBOutlet weak var randomRecipeTitle: UILabel!
    @IBOutlet weak var randomRecipeImage: UIImageView!
    
    
    var apikey = ""
    var randomRecipeId = 0
    
    override func viewDidLoad() {
        
        if let key = Bundle.main.infoDictionary? ["API_KEY"] as? String {
            apikey = key
        }
        
        fetchRandomTrivia()
        fetchRandomRecipe()
        super.viewDidLoad()
    
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
        
        URLSession.shared.fetchData(for: url) {(result: Result<randomResult, Error>) in
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
                            likesButton.setTitle(String(result.recipes[0].aggregateLikes ?? 0) , for: .normal)
                            randomRecipeId = result.recipes[0].id
                        }
                    }
                    
                    
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func recipeButtonPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailViewController") as! RecipeDetailViewController
        vc.recipeId = randomRecipeId
        vc.apikey = apikey
        self.present(vc, animated: true, completion: nil)
        print(randomRecipeId)
    }
    
}
