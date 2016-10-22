//
//  SearchPhotosViewController.swift
//  FlickrAPITestApp
//
//  Created by OkuderaYuki on 2016/10/22.
//  Copyright © 2016年 yuoku. All rights reserved.
//

import UIKit

class SearchPhotosViewController: UIViewController {
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    private func setup() {
        SearchPhotos.search(text: "abc")
        
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDataSource
extension SearchPhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //TODO: APIから取得できたら修正
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        
        //TODO: APIから取得できたら修正
        #if DEBUG
        cell.imageView.image = UIImage(named: "noImage.png")
        #endif
        
        return cell
    }
    
}
