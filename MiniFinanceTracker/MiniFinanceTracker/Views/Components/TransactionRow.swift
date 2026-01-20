
//  Created by Vipul Kumar Singh on 19/01/26.
//
//  TransactionRow.swift
//  MiniFinanceTracker
//

import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 12) {
            // Category Icon
            Image(systemName: transaction.category.icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(transaction.category.color)
                .clipShape(Circle())
            
            // Transaction Details
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.category.rawValue)
                    .font(.headline)
                
                if !transaction.note.isEmpty {
                    Text(transaction.note)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Text(transaction.formattedDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Amount
            Text(transaction.formattedAmount)
                .font(.headline)
                .foregroundColor(transaction.type == .income ? .green : .red)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    TransactionRow(transaction: Transaction(
        amount: 50.00,
        category: .food,
        type: .expense,
        note: "Lunch with team"
    ))
    .padding()
}

