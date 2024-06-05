import Foundation

struct SavedQuizListDTO: Decodable {
    let savedQuiz: [SavedQuizDTO]

    enum CodingKeys: String, CodingKey {
        case savedQuiz = "saved_quiz"
    }
}

struct SavedQuizDTO: Decodable {
    let id: Int
    let content: String
    let category: String
    let answer: Int
}

extension SavedQuizListDTO {
    func toDomain() -> SavedQuizListEntity {
        .init(savedQuiz: savedQuiz.map { $0.toDomain() })
    }
}

extension SavedQuizDTO {
    func toDomain() -> SavedQuizEntity {
        .init(
            id: id,
            content: content,
            category: CategoryType(rawValue: category) ?? .NONE,
            answer: answer
        )
    }
}
