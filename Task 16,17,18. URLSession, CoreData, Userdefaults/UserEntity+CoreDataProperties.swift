//
//  UserEntity+CoreDataProperties.swift
//  Task 16,17,18. URLSession, CoreData, Userdefaults
//
//  Created by Arseniy Matus on 29.11.2022.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var email: String?
    @NSManaged public var first_name: String?
    @NSManaged public var last_name: String?
    @NSManaged public var avatar: String?
    @NSManaged public var image: Data?
    
    public var wrappedId: Int {
        Int(id)
    }
    
    public var wrappedEmail: String {
        email ?? ""
    }
    
    public var wrappedFirstName: String {
        first_name ?? ""
    }
    
    public var wrappedLastName: String {
        last_name ?? ""
    }
    
    public var wrappedAvatar: String {
        avatar ?? ""
    }

    public var wrappedImageData: Data {
        image ?? Data()
    }

}

extension UserEntity : Identifiable {

}
