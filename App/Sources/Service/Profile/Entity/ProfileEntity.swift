import Foundation

struct ProfileEntity: Equatable, Hashable {
    let id: Int
    let name: String
    let email: String
    let profileImage: String
    let categories: [CategoryType]
    
    init(
        id: Int,
        name: String,
        email: String,
        profileImage: String,
        categories: [CategoryType]
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.profileImage = profileImage
        self.categories = categories
    }
    
    static let empty = ProfileEntity(id: 1000, name: "", email: "", profileImage: "", categories: [])
}
