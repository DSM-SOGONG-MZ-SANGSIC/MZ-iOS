import Foundation

struct FetchFriendRequestsDTO: Decodable {
    let users: [UserDTO]
    
    enum CodingKeys: String, CodingKey {
        case users = "apply_users"
    }
}

extension FetchFriendRequestsDTO {
    func toDomain() -> [UserEntity] {
        users.map { $0.toDomain() }
    }
}
