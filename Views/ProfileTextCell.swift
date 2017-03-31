//
//  ProfileTextCell.swift
//  CurrentAddress
//
//  Created by Efim Polevoi on 16/03/2017.
//
//

import UIKit

class ProfileTextCell: UITableViewCell {

  // MARK: Properties

  static let reuseIdentifier = "\(ProfileTextCell.self)"

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var valueLabel: UILabel!

  var user: User! {
    didSet {
      titleLabel.text = "Name:"
      valueLabel.text = user.name
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

  // override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
  //   super.init(style: style, reuseIdentifier: reuseIdentifier)

  // }

  // required init?(coder aDecoder: NSCoder) {
  //   fatalError("\(#function) has not been implemented")
  // }
}
