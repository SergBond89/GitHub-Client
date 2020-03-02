//
//  DetailUserViewController2.swift
//  GitHub-Client
//
//  Created by Sergey on 2/28/20.
//  Copyright © 2020 SergBondCompany. All rights reserved.
//

import UIKit
import Kingfisher

class DetailUserViewController2: UIViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var publicReposLabel: UILabel!
    
    
    var presenter: DetailUserPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "dismiss"), style: .plain, target: self, action: #selector(backButtonPressed))
        
    }
    
    @objc func backButtonPressed() {
        presenter.tapBackButton()
    }
    
}

extension DetailUserViewController2: DetailUserViewProtocol {
    func success(user: DetailUser?) {
        DispatchQueue.main.async {
            self.loginLabel.text = user?.login
            self.nameLabel.text = user?.name
            self.companyLabel.text = user?.company
            self.publicReposLabel.text = String(user?.publicRepos ?? 0)
            if let avatarUrl = user?.avatarUrl {
                let url = URL(string: avatarUrl)
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
            } else {
                self.avatarImage.image = UIImage(named: "avatar")
            }
        }
    }
    
    func failure(error: Error) {
        let alert = UIAlertController(title: "WARNING", message: "Error: \(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

