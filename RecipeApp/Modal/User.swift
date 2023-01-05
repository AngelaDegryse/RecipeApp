//
//  User.swift
//  RecipeApp
//
//  Created by Angela Degryse on 26/12/2022.
//

import Foundation
import JWTDecode

struct User{
    let id: String
    let name: String
    let email: String
    let picture: String
}
struct Metedata{
    let username: String
    let hash: String
}

extension User{
    static var empty: Self {
        return User(
          id: "",
          name: "",
          email: "",
          picture: ""
        )
    }
    
    static func from(_ idToken: String) -> Self {
        guard
          let jwt = try? decode(jwt: idToken),
          let id = jwt.subject,
          let name = jwt.claim(name: "name").string,
          let email = jwt.claim(name: "email").string,
          let picture = jwt.claim(name: "picture").string
        else {
          return .empty
        }
        return User(
              id: id,
              name: name,
              email: email,
              picture: picture
            )
          }
}
