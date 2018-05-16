//
//  API.swift
//  FlickerSearchAPI
//
//  Created by ahmedxiio on 5/16/18.
//  Copyright © 2018 ahmedxiio. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class API:NSObject {
    let apiKey = "3217502a5d4a3f52b9fb0873d2e09f15"

    class func getPhoto(searchTerm:String,completion: @escaping (_ error :Error? , _ photo :[FlickrSearchResults]?)->Void){
        
        let url = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3217502a5d4a3f52b9fb0873d2e09f15&text=\(searchTerm)&per_page=20&format=json&nojsoncallback=1"
        
        Alamofire.request(url, method: .get).responseJSON { response in
            
            switch response.result{
                
            case .failure(let error):
                
                completion(error, nil)
                print(error)
                
            case .success(let value):
                
                let json = JSON(value)
                
                guard let jsonArr = json.array else{
                    
                    completion(nil, nil)
                    
                    return
                }
                var flickrPhotos = [FlickrPhoto]()
                
                for photoObject in jsonArr {
                    guard let photoID = photoObject["id"].string,
                        let farm = photoObject["farm"].int ,
                        let server = photoObject["server"].string ,
                        let secret = photoObject["secret"].string else {
                            break
                    }
                    let flickrPhoto = FlickrPhoto(photoID: photoID, farm: farm, server: server, secret: secret)
                    
                    guard let url = flickrPhoto.flickrImageURL(),
                        let imageData = try? Data(contentsOf: url as URL) else {
                            break
                    }
                    
                    if let image = UIImage(data: imageData) {
                        flickrPhoto.thumbnail = image
                        flickrPhotos.append(flickrPhoto)
                    }
                }

                completion(nil, [FlickrSearchResults(searchTerm: searchTerm, searchResults: flickrPhotos)])
            }
        }
    }
}
