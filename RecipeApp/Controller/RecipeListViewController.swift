//
//  RecipeListViewController.swift
//  RecipeApp
//
//  Created by Angela Degryse on 04/11/2022.
//

import UIKit

class RecipeListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var recipes = [Recipe]()
    var cuisine = ""
    var searchterm = ""
    var apikey = ""
    var offset = 0
    var totalResults = 0
    @IBOutlet weak var filterKeywordLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRecipes()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func fetchRecipes(){
        var urlString = "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apikey)&number=10&offset=\(offset)"
        if(cuisine.isEmpty){
            urlString += "&query=\(searchterm)"
            filterKeywordLabel.text = searchterm
        }else{
            urlString += "&cuisine=\(cuisine)"
            filterKeywordLabel.text = cuisine
        }
        let url = URL(string: urlString)!
        
        URLSession.shared.fetchData(for: url) {(result: Result<RecipeResult, Error>) in
            switch result {
            case .success(let recipeResult):
                DispatchQueue.main.async { [self] in
                    recipes.append(contentsOf: recipeResult.results)
                    totalResults = recipeResult.totalResults
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as! RecipeDetailViewController
         self.navigationController?.pushViewController(vc, animated: true)
        vc.apikey = apikey
        vc.recipeId = recipes[indexPath.row].id
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if (offset < totalResults && indexPath.row == recipes.count-1){
            offset+=10;
            fetchRecipes();
        }
    }

}
