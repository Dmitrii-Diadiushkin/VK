//
//  FriendsTableViewCell.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 09.12.2020.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(friend: FriendsVM) {
        let image = try? Data(contentsOf: URL(string: friend.photo)!)
        self.avatarImage.image = UIImage(data: image!)
        self.nameLabel.text = friend.name
    }
}
