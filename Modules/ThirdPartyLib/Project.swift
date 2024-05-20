import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "ThirdPartyLib",
    packages: [
        .remote(
            url: "https://github.com/google/GoogleSignIn-iOS.git",
            requirement: .upToNextMajor(from: "7.1.0")
        )
    ],
    targets: [
        .target(
            name: "ThirdPartyLib", 
            destinations: .iOS,
            product: .framework,
            bundleId: "\(mzOrganizationName).ThirdPartyLib",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .SPM.KeychainSwift,
                .SPM.Kingfisher,
                .SPM.Moya,
                .SPM.RxCocoa,
                .SPM.RxFlow,
                .SPM.RxMoya,
                .SPM.RxSwift,
                .SPM.SnapKit,
                .SPM.Then,
                .package(product: "GoogleSignIn", condition: .none)
            ]
        )
    ]
)
