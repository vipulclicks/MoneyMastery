//
//  Category.swift
//  MiniFinanceTracker
//
//  Created by Vipul Kumar Singh on 19/01/26.
//


import Foundation
import SwiftUI

enum Category: String, CaseIterable, Codable {
    case food = "Food"
    case travel = "Travel"
    case bills = "Bills"
    case shopping = "Shopping"
    case entertainment = "Entertainment"
    case health = "Health"
    case salary = "Salary"
    case others = "Others"
    
    var icon: String {
        switch self {
        case .food: return "fork.knife"
        case .travel: return "airplane"
        case .bills: return "doc.text"
        case .shopping: return "cart"
        case .entertainment: return "tv"
        case .health: return "cross.case"
        case .salary: return "dollarsign.circle"
        case .others: return "ellipsis.circle"
        }
    }
    
    var color: Color {
        switch self {
        case .food: return .orange
        case .travel: return .blue
        case .bills: return .red
        case .shopping: return .purple
        case .entertainment: return .pink
        case .health: return .green
        case .salary: return .mint
        case .others: return .gray
        }
    }
}
