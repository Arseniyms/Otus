//
//  DataService.swift
//  Task 16,17,18. URLSession, CoreData, Userdefaults
//
//  Created by Arseniy Matus on 28.11.2022.
//

import UIKit
import CoreData

class DataService {
    private init() { }
    
    static var shared = { DataService() }()
    
    private static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private static let context = appDelegate.persistentContainer.viewContext
    private static let entity = NSEntityDescription.entity(forEntityName: "UserEntity", in: context)
    
    func saveToUserDefaults(users: [CacheUser]) throws {
        let encoded = try JSONEncoder().encode(users)
        UserDefaults.standard.set(encoded, forKey: "Users")
        print("ДАННЫЕ СОХРАНИЛИСЬ В UserDefaults")

    }
    
    func getFromUserDefaults(by info: String) throws -> [CacheUser] {
        guard let data = UserDefaults.standard.data(forKey: "Users") else {
            return [CacheUser]()
        }
        let decoded = try JSONDecoder().decode([CacheUser].self, from: data)
        let lowerInfo = info.lowercased()
        print("ДАННЫЕ ВЕРНУЛИСЬ C UserDefaults")
        return decoded.filter({
            $0.user.firstName.lowercased().contains(lowerInfo) ||
            $0.user.lastName.lowercased().contains(lowerInfo) ||
            $0.user.email.lowercased().contains(lowerInfo)
        })

    }
     
    
    func saveToCoreData(users: [CacheUser]) throws {
       
        
        deleteAllData()
        
        for user in users {
            let newUser = NSManagedObject(entity: DataService.entity!, insertInto: DataService.context)
            
            newUser.setValue(user.user.id, forKey: "id")
            newUser.setValue(user.user.email, forKey: "email")
            newUser.setValue(user.user.firstName, forKey: "first_name")
            newUser.setValue(user.user.lastName, forKey: "last_name")
            newUser.setValue(user.user.avatar, forKey: "avatar")
            newUser.setValue(user.image?.pngData(), forKey: "image")
            
            try DataService.context.save()
        }
        print("ДАННЫЕ СОХРАНИЛИСЬ В CoreData")

    }
    
    func getFromCoreData(by info: String) throws -> [CacheUser] {
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        request.predicate = NSPredicate(format: "email CONTAINS[cd] %@ OR first_name CONTAINS[cd] %@ OR last_name CONTAINS[cd] %@", info, info, info)
        request.returnsObjectsAsFaults = false
        let result = try DataService.context.fetch(request)
        
        var cachedUsers = [CacheUser]()
        for user in result {
            let userData = UserData(id: user.wrappedId, email: user.wrappedEmail, firstName: user.wrappedFirstName, lastName: user.wrappedLastName, avatar: user.wrappedAvatar)
            let image = UIImage(data: user.wrappedImageData)
            cachedUsers.append(CacheUser(user: userData, image: image))
        }
        
        print("ДАННЫЕ ВЕРНУЛИСЬ С CoreData")

        return cachedUsers
        
    }
    
    func deleteAllData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let arrUsrObj = try DataService.context.fetch(fetchRequest)
            for usrObj in arrUsrObj as! [NSManagedObject] {
                DataService.context.delete(usrObj)
            }
            try DataService.context.save()
        } catch let error as NSError {
            print("delete fail--",error)
        }
    }

}
