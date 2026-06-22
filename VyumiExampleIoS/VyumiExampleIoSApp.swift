//
//  VyumiExampleIoSApp.swift
//  VyumiExampleIoS
//
//  Created by Manu Mathew on 22/06/26.
//

import SwiftUI

@main
struct VyumiExampleIosApp: App {
    var body: some Scene {
        WindowGroup {
            RootViewController()
                .ignoresSafeArea()
        }
    }
}

struct RootViewController: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UINavigationController {
        UINavigationController(
            rootViewController: HomeViewController()
        )
    }

    func updateUIViewController(
        _ uiViewController: UINavigationController,
        context: Context
    ) {
    }
}
