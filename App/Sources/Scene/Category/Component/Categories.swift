import Foundation

enum Categories: String {
    case VOCA = "어휘"
    case MATH = "수학"
    case SOCIETY = "사회(정치/시사)"
    case SCIENCE = "과학"
    case HISTORY = "역사(사건/인물)"
    case MORALITY = "도덕"
    case HUMOR = "유머(신조어/넌센스)"
    case SPORTS = "스포츠"
    case ETC = "기타"
    
    var categoryName: String {
        get {
            switch self {
            case .VOCA:
                "VOCA"
            case .MATH:
                "MATH"
            case .SOCIETY:
                "SOCIETY"
            case .SCIENCE:
                "SCIENCE"
            case .HISTORY:
                "HISTORY"
            case .MORALITY:
                "MORALITY"
            case .HUMOR:
                "HUMOR"
            case .SPORTS:
                "SPORTS"
            case .ETC:
                "ETC"
            }
        }
    }
}
