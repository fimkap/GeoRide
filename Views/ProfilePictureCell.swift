//
//  ProfilePictureCell.swift
//  CurrentAddress
//
//  Created by Efim Polevoi on 15/03/2017.
//
//

import Foundation
import UIKit

class ProfilePictureCell : UITableViewCell {

  // MARK: Properties

  static let reuseIdentifier = "\(ProfilePictureCell.self)"

  private var picture = UIImageView()

  var user: User! {
    didSet {
      picture.image = user.image
    }
  }

  // MARK: Initialization
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("\(#function) has not been implemented")
  }
}
