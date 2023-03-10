//
//  File.swift
//  RecipeApp
//
//  Created by Angela Degryse on 02/11/2022.
//

import Foundation

struct RecipeResult:Decodable{
    var offset: Int
    var number: Int
    var totalResults: Int
    var results: [Recipe]
}

struct randomResult:Decodable{
    var recipes:[Recipe]
}
struct Recipe:Decodable{
    var id:Int
    var title: String
    var image: String
    var readyInMinutes: Int?
    var aggregateLikes: Int?
    var extendedIngredients:[Ingredient]?
    var analyzedInstructions: [Instruction]?
}

struct Ingredient:Codable{
    var id:Int
    var name:String
    var original:String
    var amount:Double
    var unit:String
}

struct Instruction:Decodable{
    var steps: [Step]
}

struct Step:Decodable{
    var number:Int
    var step:String
}

