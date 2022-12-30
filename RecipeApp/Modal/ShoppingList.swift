//
//  ShoppingList.swift
//  RecipeApp
//
//  Created by Angela Degryse on 29/12/2022.
//

import Foundation

struct ShoppingListResult:Decodable{
    var aisles:[Aisles]?
}

struct Aisles:Decodable{
    var aisle: String
    var items: [Item]
}

struct Item:Decodable{
    var id: Int
    var name: String
}

struct addToListBody:Codable{
    var item: String
    var parse: Bool
}
