//
//  fetchAssignmentApp.swift
//  fetchAssignment
//
//  Created by Nachiket Erlekar on 3/7/24.
//

import SwiftUI

@main
struct fetchAssignmentApp: App {
    @State private var showSplashScreen = true

    var body: some Scene {
        WindowGroup {
                    if showSplashScreen {
                        SplashScreen()
                            .onAppear {
                                // Hide the launch screen after 2 seconds
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                    withAnimation {
                                        showSplashScreen = false
                                    }
                                }
                            }
                    } else {
                        ContentView()
                    }
        }
    }
}
