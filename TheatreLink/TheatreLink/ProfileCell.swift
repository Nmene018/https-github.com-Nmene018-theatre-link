//
//  ProfileCell.swift
//  TheatreLink
//
//  Created by Natalie Meneses on 12/11/20.
//

import UIKit

class ProfileCell: UITableViewCell {
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       photoView.layer.cornerRadius = photoView.frame.size.height / 2.0
       photoView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
