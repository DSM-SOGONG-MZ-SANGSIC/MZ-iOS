import Foundation

struct FetchUsersToRequestDTO: Decodable {
    let users: [UserDTO]
}

extension FetchUsersToRequestDTO {
    func toDomain() -> [UserEntity] {
        users.map { $0.toDomain() }
    }
}
