import Foundation

enum CategoryType: String, Equatable, Hashable, Decodable {
    case VOCA = "VOCA"
    case MATH = "MATH"
    case SOCIETY = "SOCIETY"
    case SCIENCE = "SCIENCE"
    case HISTORY = "HISTORY"
    case MORALITY = "MORALITY"
    case HUMOR = "HUMOR"
    case SPORTS = "SPORTS"
    case ETC = "ETC"
    case NONE = "NONE"
    
    var categoryName: String {
        get {
            switch self {
            case .VOCA:
                "어휘"
            case .MATH:
                "수학"
            case .SOCIETY:
                "사회(정치/시사)"
            case .SCIENCE:
                "과학"
            case .HISTORY:
                "역사(사건/인물)"
            case .MORALITY:
                "도덕"
            case .HUMOR:
                "유머(신조어/넌센스)"
            case .SPORTS:
                "스포츠"
            case .ETC:
                "기타"
            case .NONE:
                "알 수 없음"
            }
        }
    }
}

func toCategoryType(_ title: String) -> String {
    switch title {
    case "어휘":
        return "VOCA"
    case "수학":
        return "MATH"
    case "사회(정치/시사)":
        return "SOCIETY"
    case "과학":
        return "SCIENCE"
    case "역사(사건/인물)":
        return "HISTORY"
    case "도덕":
        return "MORALITY"
    case "유머(신조어/넌센스)":
        return "HUMOR"
    case "스포츠":
        return "SPORTS"
    case "기타":
        return "ETC"
    default:
        return "NONE"
    }
}
