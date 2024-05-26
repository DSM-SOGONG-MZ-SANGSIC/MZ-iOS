import Foundation

struct QuestionListEntity {
    let questions: [QuestionEntity]
}

struct QuestionEntity {
    let pickID: Int
    let content: String
}
