//
//  UserslListTableViewCell.swift
//  GitHub-Client
//
//  Created by Sergey on 1/27/20.
//  Copyright © 2020 SergBondCompany. All rights reserved.
//

import UIKit

class UserslListTableViewCell: UITableViewCell {

    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
