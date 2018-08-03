//
//  Photo+CoreDataProperties.swift
//  
//
//  Created by 李灿晨 on 2018/8/3.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var liveVideoPath: String?
    @NSManaged public var photoDescription: String?
    @NSManaged public var photoIdentifier: String?
    @NSManaged public var photoPath: String?
    @NSManaged public var photoTitle: String?
    @NSManaged public var indexInAlbum: Int32
    @NSManaged public var belongTo: Album?

}
