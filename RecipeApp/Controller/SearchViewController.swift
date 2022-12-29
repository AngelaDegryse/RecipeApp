//
//  SearchViewController.swift
//  RecipeApp
//
//  Created by Angela Degryse on 29/10/2022.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    var apikey = ""
    @IBOutlet weak var searchbar: UISearchBar!
    
    let cuisines:[String] = ["African", "American", "Chinese", "French", "German", "Indian", "Italian", "Japanese", "Korean", "Mexican", "Spanish", "Thai", "Vietnamese"]
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let key = Bundle.main.infoDictionary? ["API_KEY"] as? String {
            apikey = key
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        searchbar.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cuisines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as! CollectionViewCell
        cell.configure(with: cuisines[indexPath.row])
        
        return cell
    }
    
    //cuisine selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = navigateToRecipeList()
        vc.cuisine = cuisines[indexPath.row]
    }
    
    //search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = navigateToRecipeList()
        vc.searchterm = searchBar.text ?? ""
    }
    
    private func navigateToRecipeList()->RecipeListViewController{
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RecipeListViewController") as! RecipeListViewController
         self.navigationController?.pushViewController(vc, animated: true)
        vc.apikey = apikey
        vc.cuisine = ""
        vc.searchterm = ""
        
        return vc
    }

}
