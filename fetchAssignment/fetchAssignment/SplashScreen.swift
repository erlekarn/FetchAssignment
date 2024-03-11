//
//  SplashScreen.swift
//  iosApp
//
//  Created by Nachiket Erlekar on 12/18/23.
//

import Foundation
import SwiftUI
import Alamofire


struct SplashScreen: View {
    @State private var isVisible = false
    
    var body: some View {
        HStack {
            Text("Powered by")
            Image("Fetch")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 160, height: 160)
            
            // Rest of your content
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                isVisible = true
            }
        }
        .fullScreenCover(isPresented : $isVisible) {
            ContentView() // Replace ContentView with your main content view
        }
    }
}
