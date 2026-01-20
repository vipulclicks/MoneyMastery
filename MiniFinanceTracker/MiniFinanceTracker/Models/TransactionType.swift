//
//  TransactionType.swift
//  MiniFinanceTracker
//
//  Created by Vipul Kumar Singh on 19/01/26.
//

import Foundation

enum TransactionType: String, Codable, CaseIterable {
    case income = "Income"
    case expense = "Expense"
    
    var icon: String {
        switch self {
        case .income:
            return "arrow.down.circle.fill"
        case .expense:
            return "arrow.up.circle.fill"
        }
    }
}
