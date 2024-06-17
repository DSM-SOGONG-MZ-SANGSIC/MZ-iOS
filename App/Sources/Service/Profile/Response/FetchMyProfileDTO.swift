import Foundation

struct FetchMyProfileDTO: Decodable {
    let id: Int
    let name: String
    let email: String
    let profileImage: String
    let categories: [CategoryType]
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, categories
        case profileImage = "profile_image"
    }
}

extension FetchMyProfileDTO {
    func toDomain() -> ProfileEntity {
        return .init(
            id: id,
            name: name,
            email: email,
            profileImage: profileImage,
            categories: categories
        )
    }
}
