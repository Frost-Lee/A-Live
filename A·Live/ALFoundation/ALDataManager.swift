//
//  ALDataManager.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/3.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit
import CoreData
import Photos

class ALDataManager {
    
    static var photoDirectory: String = NSHomeDirectory() + "/Documents/Photos"
    static var liveVideoDirectory: String = NSHomeDirectory() + "/Documents/LiveVideos"
    static var photoQuality: CGFloat = 0.75
    static let defaultManager = ALDataManager()
    
    func createAlbum(titled title: String, keyPhoto: UIImage, description: String?) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Album", in: context)
        let newAlbum = Album(entity: entity!, insertInto: context)
        newAlbum.albumIdentifier = UUID().uuidString
        newAlbum.albumTitle = title
        newAlbum.keyPhotoPath = savePhoto(photo: keyPhoto)
        newAlbum.albumDescription = description ?? ""
        newAlbum.numberOfPhotos = 0
        try! context.save()
    }
    
    func addPhoto(to album: String, titled title: String, photo: UIImage, index: Int, description: String?,
                  liveVideoURL: URL?) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Photo", in: context)
        let newPhoto = Photo(entity: entity!, insertInto: context)
        newPhoto.photoIdentifier = UUID().uuidString
        newPhoto.photoTitle = title
        newPhoto.indexInAlbum = Int32(index)
        newPhoto.photoPath = savePhoto(photo: photo)
        newPhoto.liveVideoPath = (liveVideoURL != nil) ? liveVideoURL!.path : ""
        newPhoto.photoDescription = description ?? ""
        newPhoto.belongTo = fetchAlbums(with: album) { album in
            album.contains?.adding(newPhoto)
            album.numberOfPhotos += 1
        }.first
        try! context.save()
    }
    
    /**
     Remove an album with identifier, the photos inside the album would also be removed
     - parameter identifier: The albumIdentifier of the album
     */
    func removeAlbum(with identifier: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Album")
        fetchRequest.predicate = NSPredicate(format: "albumIdentifier='\(identifier)'")
        let fetchedAlbums = try! context.fetch(fetchRequest) as! [Album]
        let relatedPhotos = fetchedAlbums.first?.contains
        for photo in relatedPhotos! {
            let alPhoto = photo as! Photo
            removeALPhoto(with: alPhoto.photoIdentifier!)
        }
        context.delete(fetchedAlbums.first!)
        try! context.save()
    }
    
    /**
     Remove a photo with identifier, the related photo and video file would also be removed
     - parameter identifier: The photoIdentifier of the photo
     */
    func removeALPhoto(with identifier: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        fetchRequest.predicate = NSPredicate(format: "photoIdentifier='\(identifier)'")
        let fetchedPhotos = try! context.fetch(fetchRequest) as! [Photo]
        removePhoto(with: (fetchedPhotos.first?.photoPath)!)
        removeVideo(with: (fetchedPhotos.first?.liveVideoPath)!)
        context.delete(fetchedPhotos.first!)
        try! context.save()
    }
    
    /**
     Fetch albums from persistent container.
     - parameter identifier: The albumIdentifier of the album, if it's nil, then all albums would be fetched
     - parameter completion: The operation to the first result when the results are fetched
     
     - returns: The albums fetched, if identifier is specified, the results should be one
    */
    func fetchAlbums(with identifier: String?, completion: ((Album) -> ())?) -> [Album] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Album")
        if identifier != nil {
            fetchRequest.predicate = NSPredicate(format: "albumIdentifier='\(identifier!)'")
        }
        let fetchedAlbums = try! context.fetch(fetchRequest) as! [Album]
        completion?(fetchedAlbums.first!)
        try! context.save()
        return fetchedAlbums
    }
    
    func fetchPhoto(with path: String) -> UIImage {
        let imageData = try! Data(contentsOf: URL(fileURLWithPath: path))
        return UIImage(data: imageData)!
    }
    
    func getPhoto(from resource: PHAssetResource) -> UIImage {
        let tempDirectory = URL(fileURLWithPath: NSTemporaryDirectory() + UUID().uuidString)
        PHAssetResourceManager.default().writeData(for: resource, toFile: tempDirectory, options: nil) {
            (error) in
            // Error handler here
        }
        let imageData = try! Data(contentsOf: tempDirectory)
        discardItem(with: tempDirectory)
        return UIImage(data: imageData)!
    }
    
    func saveVideo(resource: PHAssetResource?) -> URL? {
        if !FileManager.default.fileExists(atPath: ALDataManager.liveVideoDirectory) {
            try! FileManager.default.createDirectory(atPath: ALDataManager.liveVideoDirectory,
                                                     withIntermediateDirectories: true, attributes: nil)
        }
        if resource == nil {
            return nil
        } else {
            let url = URL(fileURLWithPath: ALDataManager.liveVideoDirectory + "/" + resource!.originalFilename)
            PHAssetResourceManager.default().writeData(for: resource!, toFile: url, options: nil) {
                (error) in
                // Error handler here
            }
            return url
        }
    }
    
    func discardItem(with url: URL) {
        try? FileManager.default.removeItem(at: url)
    }
    
    private func savePhoto(photo: UIImage) -> String {
        if !FileManager.default.fileExists(atPath: ALDataManager.photoDirectory) {
            try! FileManager.default.createDirectory(atPath: ALDataManager.photoDirectory,
                                                     withIntermediateDirectories: true, attributes: nil)
        }
        let photoIdentifier = "/" + UUID().uuidString + ".jpeg"
        let imageData = photo.jpegData(compressionQuality: ALDataManager.photoQuality)
        try? imageData?.write(to: URL(fileURLWithPath: ALDataManager.photoDirectory + photoIdentifier))
        return ALDataManager.photoDirectory + photoIdentifier
    }
    
    private func removePhoto(with path: String) {
        try? FileManager.default.removeItem(atPath: path)
    }
    
    private func removeVideo(with path: String) {
        try? FileManager.default.removeItem(atPath: path)
    }
    
}
