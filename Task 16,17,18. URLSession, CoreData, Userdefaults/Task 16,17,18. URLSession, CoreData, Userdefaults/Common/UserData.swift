//
//  UserData.swift
//  Task 16,17,18. URLSession, CoreData, Userdefaults
//
//  Created by Arseniy Matus on 28.11.2022.
//

import UIKit

class CacheUser: Codable {
    let user: UserData
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case user
        case image
    }
    
    init(user: UserData, image: UIImage? = nil) {
        self.user = user
        self.image = image
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        user = try container.decode(UserData.self, forKey: .user)
        
        let imageData = try container.decode(Data.self, forKey: .image)
        let decodedImage = UIImage(data: imageData) ?? UIImage()
        self.image = decodedImage
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(user, forKey: .user)

        if let jpegData = image?.jpegData(compressionQuality: 0.8) {
            try container.encode(jpegData, forKey: .image)
        }
    }
}


class resultJSON: Codable {
    let data: [UserData]
}

class UserData: Codable, CustomStringConvertible {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
    
    init(id: Int, email: String, firstName: String, lastName: String, avatar: String) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
    }
    
    
    var description: String {
        var description = ""
        description += "\nid: \(id)\n"
        description += "email: \(email)\n"
        description += "firstName: \(firstName)\n"
        description += "lastName: \(lastName)\n"
        description += "avatar: \(avatar)"
        
        return description
    }
}
