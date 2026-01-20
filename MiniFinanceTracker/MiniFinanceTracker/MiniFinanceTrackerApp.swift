
//  Created by Vipul Kumar Singh on 19/01/26.
//

//
//  MiniFinanceTrackerApp.swift
//  MiniFinanceTracker
//

import SwiftUI

@main
struct MiniFinanceTrackerApp: App {
    @StateObject private var viewModel = TransactionViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
        }
    }
}
