//
//  ApiService.swift
//  Task 16,17,18. URLSession, CoreData, Userdefaults
//
//  Created by Arseniy Matus on 28.11.2022.
//

import UIKit

class ApiService {
    private init() { }
    private let url = URL(string: "https://reqres.in/api/users")!

    static var shared = ApiService()

    func loadData(to ds: DataStorages, completion: @escaping (Result<[CacheUser], Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error {
                    completion(.failure(error))
                    return
                }

                guard let data else {
                    completion(.failure(ServiceError.dataError))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(resultJSON.self, from: data)

                    var cachedUsers = [CacheUser]()
                    let group = DispatchGroup()

                    for user in result.data {
                        let cacheUser = CacheUser(user: user)
                        cachedUsers.append(cacheUser)
                    }

                    for cachedUser in cachedUsers {
                        group.enter()
                        loadImage(from: cachedUser.user.avatar) { image in
                            cachedUser.image = image
                            group.leave()
                        }
                    }

                    group.notify(queue: .main) {
                        do {
                            switch ds {
                            case .userDefaults:
                                try DataService.shared.saveToUserDefaults(users: cachedUsers)
                            case .coreData:
                                try DataService.shared.saveToCoreData(users: cachedUsers)
                            }
                        } catch {
                            completion(.failure(error))
                            return
                        }
                        
                        completion(.success(cachedUsers))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

func loadImage(from urlString: String, completion: @escaping (UIImage) -> Void) {
    guard let url = URL(string: urlString) else {
        return
    }

    DispatchQueue.global().async {
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                completion(resizeImage(image: image, targetSize: CGSize(width: 64, height: 64)))
            }
        }
    }
}

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}
