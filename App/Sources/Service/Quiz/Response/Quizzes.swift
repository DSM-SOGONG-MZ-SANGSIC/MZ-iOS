import Foundation

struct QuizListDTO: Decodable {
    let quiz: [QuizDTO]
}

struct QuizDTO: Decodable {
    let id: Int
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case id = "quiz_id"
        case content
    }
}

extension QuizListDTO {
    func toDomain() -> QuizListEntity {
        return .init(quizList: quiz.map { $0.toDomain() })
    }
}

extension QuizDTO {
    func toDomain() -> QuizEntity {
        return .init(id: id, content: content)
    }
}
