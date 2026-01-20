
//  Created by Vipul Kumar Singh on 19/01/26.
//
//  AddTransactionView.swift
//  MiniFinanceTracker
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: TransactionViewModel
    
    @State private var amount: String = ""
    @State private var selectedCategory: Category = .food
    @State private var selectedType: TransactionType = .expense
    @State private var selectedDate: Date = Date()
    @State private var note: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Transaction Details") {
                    // Type Picker
                    Picker("Type", selection: $selectedType) {
                        ForEach(TransactionType.allCases, id: \.self) { type in
                            HStack {
                                Image(systemName: type.icon)
                                Text(type.rawValue)
                            }
                            .tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // Amount
                    HStack {
                        Text("$")
                            .foregroundColor(.secondary)
                        TextField("Amount", text: $amount)
                            .keyboardType(.decimalPad)
                    }
                    
                    // Category
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(Category.allCases, id: \.self) { category in
                            HStack {
                                Image(systemName: category.icon)
                                Text(category.rawValue)
                            }
                            .tag(category)
                        }
                    }
                    
                    // Date
                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                    
                    // Note
                    TextField("Note (optional)", text: $note)
                }
            }
            .navigationTitle("Add Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveTransaction()
                    }
                    .disabled(!isValidInput)
                }
            }
        }
    }
    
    private var isValidInput: Bool {
        guard let amountValue = Double(amount), amountValue > 0 else {
            return false
        }
        return true
    }
    
    private func saveTransaction() {
        guard let amountValue = Double(amount) else { return }
        
        let transaction = Transaction(
            amount: amountValue,
            category: selectedCategory,
            type: selectedType,
            date: selectedDate,
            note: note
        )
        
        viewModel.addTransaction(transaction)
        dismiss()
    }
}

#Preview {
    AddTransactionView()
        .environmentObject(TransactionViewModel())
}
