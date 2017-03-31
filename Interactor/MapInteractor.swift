//
//  MapInteractor.swift
//  CurrentAddress
//
//  Created by Efim Polevoi on 18/03/2017.
//
//

import UIKit
import MapKit

public class MapInteractor: NSObject {
  
//  enum City: String {
//    case Fuengirola = "Fuengirola"
//    case Benalmadena = "Benalmadena"
//  }

  static let phoneByCity:Dictionary<String,String> = ["Fuengirola":"952471000",
                                                      "Benalmadena":"952441545",
                                                      "Marbella":"952823835",
                                                      "Estepona":"952802900",
                                                      "Mijas":"952476593",
                                                      "Torremolinos":"952382744",
                                                      "San Pedro":"952774488",
                                                      "Málaga":"952176030"]
  static private var _placemark: MKPlacemark! = nil
  static var placemark: MKPlacemark {
    get { return _placemark }
    set { _placemark = newValue }
  }
  
//  func setPlacemark(_ placemark: MKPlacemark) {
//    MapInteractor._placemark = placemark
//  }
  
  func saveRiderName(_ handler: (String) -> Void) {

    if let userName = UserDefaults.standard.object(forKey: "RiderName") as? String {
      handler(userName)
    }
  }
    
  func callTaxi() {
    print("call taxi")
    print("City: \(MapInteractor._placemark.locality)")
    
      //let cleanNumber = phoneNumber.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
    guard let phoneNum = MapInteractor.phoneByCity[MapInteractor._placemark.locality!] else { return }
    //let cleanNumber = phoneNum.folding(options: .diacriticInsensitive, locale: .current)
    guard let number = URL(string: "telprompt://" + phoneNum) else { return }
      
    if #available(iOS 10.0, *) {
      UIApplication.shared.open(number, options: [:], completionHandler: nil)
    } else {
      // Fallback on earlier versions
    }
  
  }
  
  func locationCity() -> String {
    return MapInteractor._placemark.locality!
  }
  
  func locationStreet() -> String {
    return MapInteractor._placemark.thoroughfare!
  }
}
