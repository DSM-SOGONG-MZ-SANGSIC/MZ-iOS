import Foundation

struct CorrectFriendsDTO: Decodable {
    let correctFriends: Int

    enum CodingKeys: String, CodingKey {
        case correctFriends = "correct_friends"
    }
}

extension CorrectFriendsDTO {
    func toDomain() -> CorrectFriendsEntity {
        .init(correctFriends: correctFriends)
    }
}
