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
    
    /// 汎用APIメソッド(GET)
    class func requestItems(urlString: String,
                            params: [String: Any] = [String: Any](),
                            headers: [String: Any] = [String: Any](),
                            completionHandler: @escaping (Result) -> () = {_ in})
    {
        let request = Alamofire.request(urlString, method: .get, parameters: params)
        request.responseData { (response: DataResponse) in
            let result = response.result
            
            if result.isSuccess {
                guard let value = result.value else {
                    return
                }
                completionHandler(.Success(value))
            } else {
                guard let error = result.error else {
                    return
                }
                completionHandler(.Error(error))
            }
        }
    }
}

