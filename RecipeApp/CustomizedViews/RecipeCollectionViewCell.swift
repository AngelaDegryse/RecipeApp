//
//  RecipeCollectionViewCell.swift
//  RecipeApp
//
//  Created by Angela Degryse on 27/12/2022.
//

import Foundation
import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    func configure(with recipe:Recipe){
        recipeNameLabel.text = recipe.title
        recipeImage.load(urlString: recipe.image)
        recipeImage.contentMode = .scaleToFill
    }
    
//    @IBAction func heartTapped(_ sender: Any) {
//        if(heartButton.image(for: .normal)=="heart"){
//
//        }
//    }
}
