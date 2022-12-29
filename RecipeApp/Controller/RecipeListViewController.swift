//
//  RecipeListViewController.swift
//  RecipeApp
//
//  Created by Angela Degryse on 04/11/2022.
//

import UIKit

class RecipeListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var recipes = [Recipe]()
    var filterkeyword = ""
    var apikey = ""
    @IBOutlet weak var filterKeywordLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterKeywordLabel.text = filterkeyword
        fetchRecipes()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func fetchRecipes(){
        let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apikey)&cuisine=\(filterkeyword)&number=20")!
        URLSession.shared.fetchData(for: url) {(result: Result<RecipeResult, Error>) in
            switch result {
            case .success(let recipeResult):
                DispatchQueue.main.async { [self] in
                    recipes = recipeResult.results
                    self.collectionView.reloadData()
                }

            case .failure(let error):
                print(error)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count;
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCollectionCell", for: indexPath) as! RecipeCollectionViewCell
            
            cell.configure(with: recipes[indexPath.row])
            
            return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
