//
//  UserslListTableViewCell.swift
//  GitHub-Client
//
//  Created by Sergey on 1/27/20.
//  Copyright © 2020 SergBondCompany. All rights reserved.
//

import UIKit
import Kingfisher

protocol UsersListCellProtocol {
    func setUser(login: String, avatarURL: String)
}

class UserslListTableViewCell: UITableViewCell, UsersListCellProtocol {
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUser(login: String, avatarURL: String) {
        loginLabel.text = login
        
        if let url = URL(string: avatarURL) {
            DispatchQueue.main.async {
                self.avatarImage.kf.indicatorType = .activity
                self.avatarImage.kf.setImage(
                    with: url,
                    placeholder: nil,
                    options: [
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ],
                    progressBlock: nil)
            }
        }
    }
}
