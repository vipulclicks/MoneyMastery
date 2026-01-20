
//  Created by Vipul Kumar Singh on 19/01/26.
//

//
//  Transaction.swift
//  MiniFinanceTracker
//

import Foundation

struct Transaction: Identifiable, Codable, Equatable {
    let id: UUID
    var amount: Double
    var category: Category
    var type: TransactionType
    var date: Date
    var note: String
    
    init(id: UUID = UUID(),
         amount: Double,
         category: Category,
         type: TransactionType,
         date: Date = Date(),
         note: String = "") {
        self.id = id
        self.amount = amount
        self.category = category
        self.type = type
        self.date = date
        self.note = note
    }
    
    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "INR"
        let prefix = type == .expense ? "-" : "+"
        return prefix + (formatter.string(from: NSNumber(value: amount)) ?? "0.00")
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
    }
}
