//
//  ShoppingListViewController.swift
//  RecipeApp
//
//  Created by Angela Degryse on 29/12/2022.
//

import UIKit

class ShoppingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var apikey = ""
    var shoppingList = [Item]()
    let username = "angela-degryse"
    let passwordHash = "1e51c59168ae6031c23c7d964b845a3e9351e2ed"
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let key = Bundle.main.infoDictionary? ["API_KEY"] as? String {
            apikey = key
        }
        fetchShoppingList()
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchShoppingList(){
        let url = URL(string: "https://api.spoonacular.com/mealplanner/\(username)/shopping-list?apiKey=\(apikey)&hash=\(passwordHash)")!
        URLSession.shared.fetchData(for: url) {(result: Result<ShoppingListResult, Error>) in
            switch result {
            case .success(let list):
                DispatchQueue.main.async { [self] in
                    if(!list.aisles!.isEmpty){
                        for aisle in list.aisles! {
                            shoppingList.append(contentsOf: aisle.items)
                            tableView.reloadData()
                        }
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func addToShoppingList(_ sender: Any) {
        let url = URL(string: "https://api.spoonacular.com/mealplanner/\(username)/shopping-list/items?apiKey=\(apikey)&hash=\(passwordHash)")!
        
        let jsonData = try? JSONEncoder().encode(addToListBody(item: textField.text!, parse: true))
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let error = error {
                    print(error)
                } else if let data = data {
                    let item = try JSONDecoder().decode(Item.self, from: data)
                    self.shoppingList.append(item)
                } else {
                    print("Unexpected error accured")
                }
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
        self.tableView.reloadData()
        textField.text = ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            shoppingList.remove(at: indexPath.row)
            deleteItemFromListWith(id: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func deleteItemFromListWith(id:Int){
        let url = URL(string: "https://api.spoonacular.com/mealplanner/\(username)/shopping-list/items/\(id)?apiKey=\(apikey)&hash=\(passwordHash)")!
        print("https://api.spoonacular.com/mealplanner/\(username)/shopping-list/items/\(id)?apiKey=\(apikey)&hash=\(passwordHash)")
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request){ data, response, error in
            do {
                guard try JSONSerialization.jsonObject(with: data!) is [String: Any] else {
                    print("Error: Cannot convert data to JSON")
                    return
                }
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
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
