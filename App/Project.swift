import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "MZ-APP",
    organizationName: mzOrganizationName,
    targets: [
        .target(
            name: "MZ-APP",
            destinations: .iOS,
            product: .app,
            bundleId: "\(mzOrganizationName).MZ-APP",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .extendingDefault(with: uiKitPlist),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .Module.thirdPartyLib
            ]
        )
    ]
)
