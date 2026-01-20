
//  Created by Vipul Kumar Singh on 19/01/26.
//
//  TransactionListView.swift
//  MiniFinanceTracker
//

import SwiftUI

struct TransactionListView: View {
    @EnvironmentObject var viewModel: TransactionViewModel
    
    var body: some View {
        List {
            if viewModel.sortedTransactions.isEmpty {
                ContentUnavailableView(
                    "No Transactions",
                    systemImage: "list.bullet.rectangle",
                    description: Text("Add your first transaction to get started")
                )
            } else {
                ForEach(viewModel.sortedTransactions) { transaction in
                    TransactionRow(transaction: transaction)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                withAnimation {
                                    viewModel.deleteTransaction(transaction)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
        }
        .navigationTitle("All Transactions")
        .listStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        TransactionListView()
            .environmentObject(TransactionViewModel())
    }
}
