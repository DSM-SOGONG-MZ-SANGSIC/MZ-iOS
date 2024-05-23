import Foundation

struct UserEntity: Equatable, Hashable {
    let id: Int
    let name: String
    let imageURL: String
    
    init(id: Int, name: String, imageURL: String) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
}
