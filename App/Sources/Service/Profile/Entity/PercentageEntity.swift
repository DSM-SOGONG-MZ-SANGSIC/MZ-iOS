import Foundation

struct PercentageEntity: Equatable, Hashable {
    let name: String
    let percentage: [Percentage]
    
    init(name: String, percentage: [Percentage]) {
        self.name = name
        self.percentage = percentage
    }
}

struct Percentage: Equatable, Hashable {
    let category: CategoryType
    let solved: Int
    let correct: Int
    
    init(category: CategoryType, solved: Int, correct: Int) {
        self.category = category
        self.solved = solved
        self.correct = correct
    }
}
