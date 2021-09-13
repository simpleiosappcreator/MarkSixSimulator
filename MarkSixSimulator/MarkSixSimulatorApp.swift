//
//  MarkSixSimulatorApp.swift
//  MarkSixSimulator
//
//  Created by HAHA on 18/7/2021.
//

import SwiftUI

@main
struct MarkSixSimulatorApp: App {
    @StateObject var tempVM: TempViewModel = TempViewModel()

    var body: some Scene {
        WindowGroup {
            OpenAppView()
                .environmentObject(tempVM)
        }
    }
}
