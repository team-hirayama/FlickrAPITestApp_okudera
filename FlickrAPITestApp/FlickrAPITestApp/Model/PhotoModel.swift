//
//  PhotoModel.swift
//  FlickrAPITestApp
//
//  Created by OkuderaYuki on 2016/10/22.
//  Copyright © 2016年 yuoku. All rights reserved.
//

import UIKit

class PhotoModel: NSObject {
    struct PhotoModel {
        var image = ""
    }
    
    struct PhotosModel {
        var photos = [PhotoModel]()
    }

}
