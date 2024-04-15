import ProjectDescription

public extension TargetDependency {
    struct Module {}
}

public extension TargetDependency.Module {
    static let thirdPartyLib = module(name: "ThirdPartyLib")

    private static func module(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Modules/\(name)"),
            condition: .none
        )
    }
}
