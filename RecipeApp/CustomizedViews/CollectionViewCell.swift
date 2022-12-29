//
//  CollectionViewCell.swift
//  RecipeApp
//
//  Created by Angela Degryse on 04/11/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryCellLabel: UILabel!
    func configure(with data:String){
        categoryCellLabel.text = data
    }
}
