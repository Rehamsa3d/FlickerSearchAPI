//
//  ViewController.swift
//  FlickerSearchAPI
//
//  Created by ahmedxiio on 5/16/18.
//  Copyright © 2018 ahmedxiio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Mark:Propereties
    @IBOutlet weak var searchTextField: UITextField!
    
    var photo:FlickrPhoto?
    fileprivate var searches = [FlickrSearchResults]()
    fileprivate let flickr = Flickr()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ searchTextField: UITextField) -> Bool {
        if searchTextField.text == "" {
            self.messageToDisplay(messageToDisplay: "please enter search word to start")
        }else{
            performSegue(withIdentifier: "resultVC", sender: searchTextField.text)
        }
        return true
    }
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultVC" {
            if let vc = segue.destination as? ResulteVC {
                vc.type = sender as? String
            }
        }
    }
}


