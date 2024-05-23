import Foundation

struct UserDTO: Decodable {
    let id: Int
    let name: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "profile_image"
    }
}
extension UserDTO {
    func toDomain() -> UserEntity {
        return .init(id: id, name: name, imageURL: imageURL)
    }
}
