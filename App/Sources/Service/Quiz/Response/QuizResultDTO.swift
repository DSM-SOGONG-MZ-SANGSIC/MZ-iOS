import Foundation

struct QuizResultDTO: Decodable {
    let answer: Bool
    let commentation: String
}

extension QuizResultDTO {
    func toDomain() -> QuizResultEntity {
        .init(answer: answer, commentation: commentation)
    }
}
