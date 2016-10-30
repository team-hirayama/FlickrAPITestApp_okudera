//
//  PhotoModel.swift
//  FlickrAPITestApp
//
//  Created by OkuderaYuki on 2016/10/22.
//  Copyright © 2016年 yuoku. All rights reserved.
//

import UIKit

struct PhotoInfoModel {
    var id = ""
    var secret = ""
    var server = ""
    var farm = ""
}

struct PhotosInfoModel {
    var page = ""
    var pages = ""
    var parpage = ""
    var total = ""
    var photos = [PhotoInfoModel]()
}
