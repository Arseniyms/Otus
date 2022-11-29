//
//  DataStorages.swift
//  Task 16,17,18. URLSession, CoreData, Userdefaults
//
//  Created by Arseniy Matus on 28.11.2022.
//

import Foundation


enum DataStorages: String, CustomStringConvertible {
    case userDefaults = "UserDefaults"
    case coreData = "CoreData"
    
    var description: String {
        get {
            self.rawValue
        }
    }
}
