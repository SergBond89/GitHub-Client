//
//  DetailUserViewController.swift
//  GitHub-Client
//
//  Created by Sergey on 2/20/20.
//  Copyright © 2020 SergBondCompany. All rights reserved.
//

import UIKit
import Kingfisher

protocol DetailUserViewProtocol: class {
    func success(user: DetailUser?)
    func failure(error: Error)
}

class DetailUserViewController: UIViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    var presenter: DetailUserPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "dismiss"), style: .plain, target: self, action: #selector(backButtonPressed))
        
    }
    
    @objc func backButtonPressed() {
        presenter.tapBackButton()
    }
    
}

extension DetailUserViewController: DetailUserViewProtocol {
    func success(user: DetailUser?) {
        DispatchQueue.main.async {
            self.loginLabel.text = user?.login
            self.nameLabel.text = user?.name
            self.companyLabel.text = user?.company
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
