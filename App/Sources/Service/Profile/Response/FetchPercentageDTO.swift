import Foundation

struct FetchPercentageDTO: Decodable {
    let name: String
    let percentage: [PercentageDTO]
    
    enum CodingKeys: String, CodingKey {
        case name, percentage
    }
}
extension FetchPercentageDTO {
    func toDomain() -> PercentageEntity {
        return .init(
            name: name,
            percentage: percentage.map { $0.toDomain() }
        )
    }
}

struct PercentageDTO: Decodable {
    let category: CategoryType
    let solved: Int
    let correct: Int
    
    enum CodingKeys: String, CodingKey {
        case category
        case solved = "solved_quiz"
        case correct = "correct_quiz"
    }
}
extension PercentageDTO {
    func toDomain() -> Percentage {
        return .init(
            category: category,
            solved: solved,
            correct: correct
        )
    }
}
