//
//  AlbumView.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/3.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit

protocol AlbumDelegate {
    func albumDidSelected(album: Album)
}

class AlbumView: UIView {
    
    @IBOutlet weak var albumCollectionView: UICollectionView! {
        didSet {
            albumCollectionView.register(UINib(nibName: "AlbumCollectionViewCell",
                bundle: Bundle.main), forCellWithReuseIdentifier: "albumCollectionViewCell")
            albumCollectionView.delegate = self
            albumCollectionView.dataSource = self
        }
    }
    
    var albums: [Album] = [] {
        didSet {
            albumCollectionView.reloadData()
        }
    }
    
    var delegate: AlbumDelegate?
    
    func reloadAlbums() {
        albums = ALDataManager.defaultManager.fetchAlbums(with: nil, completion: nil)
    }

}


extension AlbumView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumCollectionView.dequeueReusableCell(withReuseIdentifier: "albumCollectionViewCell",
                                                           for: indexPath) as! AlbumCollectionViewCell
        cell.album = albums[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.albumDidSelected(album: albums[indexPath.row])
    }
}
