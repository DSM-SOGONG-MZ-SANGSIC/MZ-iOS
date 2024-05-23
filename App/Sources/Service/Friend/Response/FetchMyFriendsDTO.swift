import Foundation

struct FetchMyFriendsDTO: Decodable {
    let friends: [UserDTO]
}

extension FetchMyFriendsDTO {
    func toDomain() -> [UserEntity] {
        friends.map { $0.toDomain() }
    }
}
