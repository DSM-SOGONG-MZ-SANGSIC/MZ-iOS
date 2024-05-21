import Foundation

struct Quizzes: Decodable {
    let quiz: [Quizz]
}

struct Quizz: Decodable {
    let id: Int
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case id = "quiz_id"
        case content
    }
}
