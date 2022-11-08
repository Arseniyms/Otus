//
//  Storage.swift
//  Task 12,13. VIPER, Patterns
//
//  Created by Arseniy Matus on 08.11.2022.
//

import Foundation

class Storage {
    private init() {

    }
    
    static private var user = User(name: "Empty", lastName: "Empty", age: 0, email: "Empty")

    
    static var shared: Storage { Storage() }
    
    func getUser() -> User {
//        print(Storage.user)
        return Storage.user
    }
    
    func setUser(_ user: User) {
        Storage.user.age = user.age
        Storage.user.lastName = user.lastName
        Storage.user.name = user.name
        Storage.user.email = user.email
    }
}
