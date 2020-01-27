//
//  ActivityIndicator.swift
//  GitHub-Client
//
//  Created by Sergey on 1/27/20.
//  Copyright © 2020 SergBondCompany. All rights reserved.
//

import UIKit

class ActivityIndicator {
    
    static func createActivityIndicator(activityIndicator: UIActivityIndicatorView, view: UIView){
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    static func removeActivityIndicator(activityIndicator: UIActivityIndicatorView){
        DispatchQueue.main.async{
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
}
