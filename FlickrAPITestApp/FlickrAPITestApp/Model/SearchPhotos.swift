//
//  SearchPhotos.swift
//  FlickrAPITestApp
//
//  Created by OkuderaYuki on 2016/10/22.
//  Copyright © 2016年 yuoku. All rights reserved.
//

import UIKit

private struct elementName {
    let id = "id"
    let secret = "secret"
    let server = "server"
    let farm = "farm"
}

class SearchPhotos: NSObject {

    var photoInfoModel = PhotoInfoModel()
    var photosInfoModel = PhotosInfoModel()
    
    func photoURL(photoInfo: PhotoInfoModel) -> String {
        return String(format: "https://farm%@.staticflickr.com/%@/%@_%@.jpg", photoInfo.farm, photoInfo.server, photoInfo.id, photoInfo.secret)
    }
    
    
    func search(text: String, pageString: String, completionHandler: @escaping (PhotosInfoModel) -> Void) {
        
        let urlString = "https://api.flickr.com/services/rest/"
        let perPageString = "50"
        
        let params: [String: Any] = ["method": "flickr.photos.search",
                                     "per_page": perPageString,
                                     "text": text,
                                     "page": pageString,
                                     "api_key": "10ba93bbe49a6480d765ce486673954a"]
        
        let apiClient = APIClient()
        
        apiClient.requestItems(urlString: urlString, params: params) { (response) in
            switch response {
            case .Success(let responseData):
                
                let responseData = responseData as! Data
                
                let xml = XMLParser(data: responseData)
                xml.delegate = self
                xml.parse()
                
                debugPrint("---------XMLParse END---------")

                completionHandler(self.photosInfoModel)
                
            case .Error(let error):
                debugPrint("error:\(error)")
            }
        }
    }

}

extension SearchPhotos: XMLParserDelegate {
    
    func parserDidStartDocument(_ parser: XMLParser) {
        photosInfoModel = PhotosInfoModel()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        guard let idString = attributeDict["id"], let secretString = attributeDict["secret"],
            let serverString = attributeDict["server"], let farmString = attributeDict["farm"] else {
                return
        }
        
        self.photoInfoModel = PhotoInfoModel()
        
        // スペース、改行を削除した文字列をphotoInfoModelに格納
        self.photoInfoModel.id = idString.trimmingCharacters(in: .whitespacesAndNewlines)
        self.photoInfoModel.secret = secretString.trimmingCharacters(in: .whitespacesAndNewlines)
        self.photoInfoModel.server = serverString.trimmingCharacters(in: .whitespacesAndNewlines)
        self.photoInfoModel.farm = farmString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        self.photosInfoModel.photos.append(self.photoInfoModel)
    }
}
