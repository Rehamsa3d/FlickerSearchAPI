//
//  MessageAlert.swift
//  FlickerSearchAPI
//
//  Created by ahmedxiio on 5/16/18.
//  Copyright © 2018 ahmedxiio. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    
    func messageToDisplay(messageToDisplay: String){
        let alertController = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
        }
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
}
