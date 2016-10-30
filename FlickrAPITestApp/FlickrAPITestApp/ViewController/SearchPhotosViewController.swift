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
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField!
    
    fileprivate var images = [UIImage]()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        
        collectionView.dataSource = self
        textField.delegate = self

        // 検索ボタンをdisable
        searchButton.isEnabled = false
    }
    
    
    // MARK: - IBAction
    @IBAction func tappedSearchButton(_ sender: AnyObject) {
        
        guard let searchText = textField.text else {
            return
        }
        
        let searchPhotos = SearchPhotos()
        searchPhotos.search(text: searchText, pageString: "2") { (responseImages) in
            self.images = responseImages
            self.collectionView.reloadData()
            
            if self.images.count == 0 {
                let noImageMessage = "該当する写真がありません。検索ワードを変更してお試しください。"
                let alert: UIAlertController = UIAlertController(title: "",
                                                                 message: noImageMessage,
                                                                 preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension SearchPhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.imageView.image = self.images[indexPath.row]

        
        return cell
    }
}

// MARK: - UITextFieldDelegate
extension SearchPhotosViewController: UITextFieldDelegate {
    
    // Doneタップでキーボードをクローズ
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // textFieldの文字列の長さで検索ボタンの活性/非活性を変更する
        if let textFieldText = textField.text {
            let length = textFieldText.characters.count - range.length + string.characters.count
            debugPrint("newStringLength:\(length)")
            
            // 未入力でなければ、検索ボタンenable
            searchButton.isEnabled = !(length == 0)
        }
        
        return true
    }
}
