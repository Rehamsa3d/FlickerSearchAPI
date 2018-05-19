//
//  ResulteVC.swift
//  FlickerSearchAPI
//
//  Created by ahmedxiio on 5/16/18.
//  Copyright © 2018 ahmedxiio. All rights reserved.
//
//pod 'Alamofire'
//pod 'SwiftyJSON'
//pod 'NVActivityIndicatorView'
//pod 'Agrume'
//pod 'BouncyLayout'
import UIKit
import NVActivityIndicatorView
import BouncyLayout
import Agrume

class ResulteVC: UIViewController {
    
    //Mark:Propereties
    var type:String?
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searches = [FlickrSearchResults]()
    let flickr = Flickr()
    
    let layout = BouncyLayout()
    let activityData = ActivityData(size: CGSize(width: 70, height: 70),type: .ballZigZag, color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), backgroundColor: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 0))
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        startAnimating()
        handelRefresh()
    }
    //CollectionView
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    //IndicatorPresenter startAnimating
    func startAnimating()  {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    //IndicatorPresenter stopAnimating
    func stopAnimating()  {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    //handelRefresh of Flicker API
    func handelRefresh() {
        
        API.getPhoto(searchTerm: type!) { (error , Photos) in
            
            if let results = Photos {
                // 3
                print("Found \(results.searchResults.count) matching \(results.searchTerm)")
                self.searches.insert(results, at: 0)
                
                // 4
                self.collectionView?.reloadData()
                self.stopAnimating()
            }
            
//            
//            if Photos != nil {
//
////                self.searches.append(Photos)
////                self.searches.insert(Photos, at: 0)
//
//                self.collectionView?.reloadData()
//            }
//            self.stopAnimating()

        }

//        flickr.searchFlickrForTerm(type!) {
//            results, error in
//
//            if let error = error {
//                // 2
//                print("Error searching : \(error)")
//                self.stopAnimating()
//                self.messageToDisplay(messageToDisplay: "no matches Results")
//
//                return
//            }
//
//            if let results = results {
//                // 3
//                print("Found \(results.searchResults.count) matching \(results.searchTerm)")
//                self.searches.insert(results, at: 0)
//
//                // 4
//                self.collectionView?.reloadData()
//                self.stopAnimating()
//            }
//        }
        
    }
    
    
}
// MARK: - UICollectionViewDataSource
extension ResulteVC:UICollectionViewDelegate,UICollectionViewDataSource {
    //1
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searches.count
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return searches[section].searchResults.count
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! ImgCell
        //2
        let flickrPhoto = photoForIndexPath(indexPath)
        //3
        cell.imag.image = flickrPhoto.thumbnail
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let flickrPhoto = photoForIndexPath(indexPath)
        
        let agrume = Agrume(image: flickrPhoto.thumbnail!)
        agrume.show(from: self)
        
    }
}
// MARK: - Private
private extension ResulteVC {
    func photoForIndexPath(_ indexPath: IndexPath) -> FlickrPhoto {
        return searches[(indexPath as NSIndexPath).section].searchResults[(indexPath as NSIndexPath).row]
    }
}

extension ResulteVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let cellWidth = (screenWidth-30)/3
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
}
