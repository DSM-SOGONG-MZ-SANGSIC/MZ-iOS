import Foundation

struct SavedQuizListEntity {
    let savedQuiz: [SavedQuizEntity]

    enum CodingKeys: String, CodingKey {
        case savedQuiz = "saved_quiz"
    }
}

struct SavedQuizEntity {
    let id: Int
    let content: String
    let category: CategoryType
    let answer: Int
}
