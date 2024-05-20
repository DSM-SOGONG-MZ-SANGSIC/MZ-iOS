import ProjectDescription

// MARK: - UIkit의 Delegate를 사용하기 위한 설정
public let uiKitPlist: [String: Plist.Value] = [
    "UILaunchStoryboardName": "LaunchScreen.storyboard",
    "GIDClientID": "902580138888-cg7rrjfqjrrso86n3dj2t7k3vad42rm2.apps.googleusercontent.com",
    "CFBundleURLTypes": [
        [
            "CFBundleTypeRole": "Editor",
            "CFBundleURLSchemes": ["com.googleusercontent.apps.902580138888-cg7rrjfqjrrso86n3dj2t7k3vad42rm2"]
        ]
    ],
    "UIApplicationSceneManifest": [
        "UIApplicationSupportsMultipleScenes": false,
        "UISceneConfigurations": [
            "UIWindowSceneSessionRoleApplication": [
                [
                    "UISceneConfigurationName": "Default Configuration",
                    "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                ]
            ]
        ]
    ]
]
