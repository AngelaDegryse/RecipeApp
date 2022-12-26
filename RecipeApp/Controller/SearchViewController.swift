//
//  SearchViewController.swift
//  RecipeApp
//
//  Created by Angela Degryse on 29/10/2022.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var apikey = ""
    @IBOutlet weak var searchbar: UISearchBar!
    
    let cuisines:[String] = ["African", "American", "Chinese", "French", "German", "Indian", "Italian", "Japanese", "Korean", "Mexican", "Middle Eastern", "Spanish", "Thai"]
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let key = Bundle.main.infoDictionary? ["API_KEY"] as? String {
            apikey = key
        }
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cuisines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as! CollectionViewCell
        
        cell.configure(with: cuisines[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(cuisines[indexPath.row])
    }
    
    

    
    // MARK: - Navigation

    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let url = URL(string: "https://api.spoonacular.com/food/trivia/random?apiKey=\(apikey)")!
        
    }
    

}
