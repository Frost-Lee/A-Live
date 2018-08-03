//
//  ALDataManager.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/3.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit
import CoreData

class ALDataManager {
    
    static var photoDirectory: String = NSHomeDirectory() + "/Photos"
    static var liveVideoDirectory: String = NSHomeDirectory() + "/LiveVideos"
    static var photoQuality: CGFloat = 0.75
    static let defaultManager = ALDataManager()
    
    func createAlbum(with title: String, keyPhoto: UIImage, description: String?) {
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
    
    func addPhoto(to album: String, with title: String, photo: UIImage, description: String?,
                  liveVideoURL: URL?) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Photo", in: context)
        let newPhoto = Photo(entity: entity!, insertInto: context)
        newPhoto.photoIdentifier = UUID().uuidString
        newPhoto.photoTitle = title
        newPhoto.photoPath = savePhoto(photo: photo)
        newPhoto.liveVideoPath = (liveVideoURL != nil) ? saveVideo(videoURL: liveVideoURL!) : ""
        newPhoto.photoDescription = description ?? ""
        newPhoto.belongTo = fetchAlbum(with: album)!
    }
    
    private func fetchAlbum(with identifier: String) -> Album? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Album")
        fetchRequest.predicate = NSPredicate(format: "albumIdentifier=\(identifier)")
        let fetchedAlbums = try! context.fetch(fetchRequest) as! [Album]
        return fetchedAlbums.first
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
    
    private func saveVideo(videoURL: URL) -> String {
        if !FileManager.default.fileExists(atPath: ALDataManager.liveVideoDirectory) {
            try! FileManager.default.createDirectory(atPath: ALDataManager.liveVideoDirectory,
                                                     withIntermediateDirectories: true, attributes: nil)
        }
        let videoIdentifier = "/" + UUID().uuidString
        try! FileManager.default.copyItem(at: videoURL, to: URL(fileURLWithPath:
            ALDataManager.liveVideoDirectory + videoIdentifier))
        return ALDataManager.liveVideoDirectory + videoIdentifier
    }
    
}
