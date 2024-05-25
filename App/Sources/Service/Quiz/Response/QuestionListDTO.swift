import Foundation

struct QuestionListDTO: Decodable {
    let questions: [QuestionDTO]

    enum CodingKeys: String, CodingKey {
        case questions = "picks"
    }
}

struct QuestionDTO: Decodable {
    let pickID: Int
    let content: String

    enum CodingKeys: String, CodingKey {
        case pickID = "pick_id"
        case content
    }
}

extension QuestionListDTO {
    func toDomain() -> QuestionListEntity {
        .init(questions: questions.map { $0.toDomain() })
    }
}

extension QuestionDTO {
    func toDomain() -> QuestionEntity {
        .init(pickID: pickID, content: content)
    }
}
