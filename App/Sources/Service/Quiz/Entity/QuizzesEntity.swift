import Foundation

struct QuizListEntity {
    let quizList: [QuizEntity]

    init(quizList: [QuizEntity]) {
        self.quizList = quizList
    }
}

struct QuizEntity {
    let id: Int
    let content: String

    init(id: Int, content: String) {
        self.id = id
        self.content = content
    }
}
