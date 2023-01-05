//
//  RecipeDetailViewController.swift
//  RecipeApp
//
//  Created by Angela Degryse on 29/12/2022.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    var recipeId = 0
    var apikey = ""
    
    @IBOutlet weak var recipeIamge: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var IngredientsTextviex: UITextView!
    @IBOutlet weak var instructionsTextview: UITextView!
    @IBOutlet weak var readyTimeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRecipeDetails()
    }
    
    func fetchRecipeDetails(){
        let url = URL(string: "https://api.spoonacular.com/recipes/\(recipeId)/information?apiKey=\(apikey)")!
        URLSession.shared.fetchData(for: url) {(result: Result<Recipe, Error>) in
            switch result {
            case .success(let recipe):
                DispatchQueue.main.async { [self] in
                    recipeTitleLabel.text = recipe.title
                    readyTimeLabel.text = "Ready in \(recipe.readyInMinutes ?? 0) minutes"
                    recipeIamge.load(urlString: recipe.image)
                    likeButton.setTitle(String(recipe.aggregateLikes ?? 0) , for: .normal)
                    for ingredient in recipe.extendedIngredients! {
                        IngredientsTextviex.text+="- \(ingredient.original)\n"
                    }
                    for instruction in recipe.analyzedInstructions!{
                        for step in instruction.steps{
                            instructionsTextview.text += "\(step.number). \(step.step) \n"
                        }
                        
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
