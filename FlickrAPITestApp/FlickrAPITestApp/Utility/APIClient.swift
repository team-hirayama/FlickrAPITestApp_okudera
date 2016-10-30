//
//  APIClient.swift
//  FlickrAPITestApp
//
//  Created by OkuderaYuki on 2016/10/22.
//  Copyright © 2016年 yuoku. All rights reserved.
//

import UIKit
import Alamofire

class APIClient: NSObject {

    enum Result {
        case Success(Any)
        case Error(Error)
    }
    
    /// APIメソッド(GET)
    func requestItems(urlString: String,
                      params: [String: Any] = [String: Any](),
                      headers: [String: Any] = [String: Any](),
                      completionHandler: @escaping (Result) -> () = {_ in})
    {
        let request = Alamofire.request(urlString, method: .get, parameters: params)
        
        request.response { response in
            if let error = response.error {
                completionHandler(.Error(error))
                return
            }
            
            if let data = response.data {
                completionHandler(.Success(data))
                return
            }
        }
    }
}
