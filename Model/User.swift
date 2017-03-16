//
//  User.swift
//  CurrentAddress
//
//  Created by Efim Polevoi on 15/03/2017.
//
//

import Foundation
import UIKit

struct User {

  // MARK: Properties

  var image: UIImage
  var name: String
  var age: Int
  var language: String

  enum ProfileField {
      case image 
      case name 
      case age 
      case language 

      static let all: [ProfileField] = [
        .image,
        .name,
        .age,
        .language
      ]
  }

  static let testUser = User(UIImage(named: "TestUser.jpg")!, "Greg", 52, "Spanish")

  // MARK: Initialization
  init(_ image: UIImage, _ name: String, _ age: Int, _ language: String) {
    self.image = image
    self.name = name
    self.age = age
    self.language = language
  }
}
