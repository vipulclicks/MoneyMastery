
//  Created by Vipul Kumar Singh on 19/01/26.
//
//
//  MonthlySummary.swift
//  MiniFinanceTracker
//

import Foundation

struct MonthlySummary {
    let income: Double
    let expense: Double
    let balance: Double
    let topCategory: Category?
    let transactionCount: Int
    let avgDailySpending: Double
    
    var formattedIncome: String {
        formatCurrency(income)
    }
    
    var formattedExpense: String {
        formatCurrency(expense)
    }
    
    var formattedBalance: String {
        formatCurrency(balance)
    }
    
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: value)) ?? "$0.00"
    }
}
