//
//  AddPhotoViewController.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/2.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit
import Photos
import CoreServices

class AddPhotoViewController: UIViewController {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTitleTextField: UITextField!
    @IBOutlet weak var photoDescriptionTextField: UITextField!
    @IBOutlet weak var albumCollectionView: UICollectionView! {
        didSet {
            albumCollectionView.register(UINib(nibName: "AlbumCollectionViewCell",
                bundle: Bundle.main), forCellWithReuseIdentifier: "albumCollectionViewCell")
            albumCollectionView.setContentOffset(CGPoint(x: 16, y: 0), animated: false)
        }
    }
    
    var albums: [Album]! {
        didSet {
            albumCollectionView.reloadData()
        }
    }
    var selectedAlbum: Int = 0 {
        didSet {
            albumCollectionView.reloadItems(at: [IndexPath(row: selectedAlbum, section: 0),
                                                 IndexPath(row: oldValue, section: 0)])
        }
    }
    
    private var liveVideo: PHAssetResource? = nil
    private var shouldLiveVideoSaved: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albums = ALDataManager.defaultManager.fetchAlbums(with: nil, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        let videoURL = shouldLiveVideoSaved ? ALDataManager.defaultManager.saveVideo(resource: liveVideo) : nil
        ALDataManager.defaultManager.addPhoto(to: albums[selectedAlbum].albumIdentifier!, titled:
            photoTitleTextField.text!, photo: photoImageView.image!, index:
            albums[selectedAlbum].contains!.count, description: photoDescriptionTextField.text!,
                                                   liveVideoURL: videoURL)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeLivePhoto as String, kUTTypeImage as String]
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func fetchImage(with path: String) -> UIImage {
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        return UIImage(data: data)!
    }
    
}


extension AddPhotoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumCollectionView.dequeueReusableCell(withReuseIdentifier:
            "albumCollectionViewCell", for: indexPath) as! AlbumCollectionViewCell
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
        collectionView.deselectItem(at: indexPath, animated: true)
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


extension AddPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
        info: [UIImagePickerController.InfoKey : Any]) {
        shouldLiveVideoSaved = false
        if let livePhoto = info[UIImagePickerController.InfoKey.livePhoto] as? PHLivePhoto {
            let assetResources = PHAssetResource.assetResources(for: livePhoto)
            for resource in assetResources {
                if resource.type == .photo {
                    photoImageView.image = ALDataManager.defaultManager.getPhoto(from: resource)
                } else if resource.type == .pairedVideo {
                    liveVideo = resource
                    shouldLiveVideoSaved = true
                }
            }
        } else {
            let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            photoImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
}
