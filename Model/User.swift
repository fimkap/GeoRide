//
//  User.swift
//  CurrentAddress
//
//  Created by Efim Polevoi on 15/03/2017.
//
//

import Foundation
import UIKit
import MapKit

// TODO: use struct when change to Swift for the caller
@objc class User: NSObject {

  // MARK: Properties

  var image: UIImage
  var name: String
  var age: Int
  var language: String
  var placemark: MKPlacemark

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

  static var testUser = User(UIImage(named: "TestUser.jpg")!, "Greg", 52, "Spanish")

  // MARK: Initialization
  init(_ image: UIImage, _ name: String, _ age: Int, _ language: String) {
    self.image = image
    self.name = name
    self.age = age
    self.language = language
    if #available(iOS 10.0, *) {
      self.placemark = MKPlacemark(coordinate: CLLocationCoordinate2D())
    } else {
      // Fallback on earlier versions
      self.placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(), addressDictionary: nil)
    }
  }
}
