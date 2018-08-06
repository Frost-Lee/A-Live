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
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var currentAlbumView: CurrentAlbumView!
    @IBOutlet weak var albumCollectionView: UICollectionView! {
        didSet {
            albumCollectionView.register(UINib(nibName: "AlbumCollectionViewCell",
                bundle: Bundle.main), forCellWithReuseIdentifier: "albumCollectionViewCell")
        }
    }
    
    var albums: [Album] = [] {
        didSet {
            albumCollectionView.reloadData()
        }
    }
    var selectedAlbum: Int = -1 {
        didSet {
            albumCollectionView.reloadItems(at: [IndexPath(row: selectedAlbum, section: 0)])
            if oldValue >= 0 {
                albumCollectionView.reloadItems(at: [IndexPath(row: oldValue, section: 0)])
            }
        }
    }
    
    var delegate: AlbumDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlbumView", owner: self, options: nil)
        self.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("AlbumView", owner: self, options: nil)
        self.addSubview(view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view.setNeedsLayout()
    }
    
    func reloadAlbums() {
        albums = ALDataManager.defaultManager.fetchAlbums(with: nil, completion: nil)
    }

}


extension AlbumView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
        indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumCollectionView.dequeueReusableCell(withReuseIdentifier: "albumCollectionViewCell",
                                                           for: indexPath) as! AlbumCollectionViewCell
        cell.album = albums[indexPath.row]
        if indexPath.row == selectedAlbum {
            cell.highLight()
        } else {
            cell.dehighLight()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedAlbum = indexPath.row
        currentAlbumView.album = albums[indexPath.row]
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.albumDidSelected(album: albums[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.frame.height - 10.0) / 2
        let width = height * 1.6
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
