//
//  SearchPhotos.swift
//  FlickrAPITestApp
//
//  Created by OkuderaYuki on 2016/10/22.
//  Copyright © 2016年 yuoku. All rights reserved.
//

import UIKit

class SearchPhotos: NSObject {
    
    class func search(text: String) {
        let urlString = "https://api.flickr.com/services/rest/"
        let params: [String: Any] = ["api_key": "10ba93bbe49a6480d765ce486673954a",
                                     "method": "flickr.photos.search",
                                     "text": text]

        
        APIClient.requestItems(urlString: urlString, params: params) { (response) in
            switch response {
            case .Success(let items):
                debugPrint(items)
                
//                items
                
            case .Error(let error):
                debugPrint("error:\(error)")
            }
        }
    }
}
