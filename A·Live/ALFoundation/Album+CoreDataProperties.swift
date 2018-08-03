//
//  Album+CoreDataProperties.swift
//  
//
//  Created by 李灿晨 on 2018/8/3.
//
//

import Foundation
import CoreData


extension Album {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Album> {
        return NSFetchRequest<Album>(entityName: "Album")
    }

    @NSManaged public var albumTitle: String?
    @NSManaged public var keyPhotoPath: String?
    @NSManaged public var numberOfPhotos: Int32
    @NSManaged public var albumDescription: String?
    @NSManaged public var albumIdentifier: String?
    @NSManaged public var contains: NSSet?

}

// MARK: Generated accessors for contains
extension Album {

    @objc(addContainsObject:)
    @NSManaged public func addToContains(_ value: Photo)

    @objc(removeContainsObject:)
    @NSManaged public func removeFromContains(_ value: Photo)

    @objc(addContains:)
    @NSManaged public func addToContains(_ values: NSSet)

    @objc(removeContains:)
    @NSManaged public func removeFromContains(_ values: NSSet)

}
