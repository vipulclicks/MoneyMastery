//
//  TransactionViewModel.swift
//  MiniFinanceTracker
//
//  Created by Vipul Kumar Singh on 19/01/26.


import Foundation
import Combine

class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var selectedMonth: Date = Date()
    
    private let persistenceManager = PersistenceManager.shared
    
    init() {
        loadTransactions()
    }
    
    // MARK: - CRUD Operations
    
    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
        saveTransactions()
    }
    
    func deleteTransaction(_ transaction: Transaction) {
        transactions.removeAll { $0.id == transaction.id }
        saveTransactions()
    }
    
    func updateTransaction(_ transaction: Transaction) {
        if let index = transactions.firstIndex(where: { $0.id == transaction.id }) {
            transactions[index] = transaction
            saveTransactions()
        }
    }
    
    // MARK: - Persistence
    
    private func saveTransactions() {
        do {
            try persistenceManager.save(transactions)
        } catch {
            print("Error saving transactions: \(error)")
        }
    }
    
    private func loadTransactions() {
        do {
            transactions = try persistenceManager.load()
        } catch {
            print("Error loading transactions: \(error)")
            transactions = []
        }
    }
    
    func clearAllData() {
        transactions = []
        do {
            try persistenceManager.delete()
        } catch {
            print("Error clearing data: \(error)")
        }
    }
    
    // MARK: - Computed Properties
    
    var sortedTransactions: [Transaction] {
        transactions.sorted { $0.date > $1.date }
    }
    
    var currentMonthTransactions: [Transaction] {
        let calendar = Calendar.current
        return transactions.filter {
            calendar.isDate($0.date, equalTo: selectedMonth, toGranularity: .month)
        }
    }
    
    // MARK: - Analytics
    
    func monthlySummary(for month: Date = Date()) -> MonthlySummary {
        let calendar = Calendar.current
        
        let filtered = transactions.filter {
            calendar.isDate($0.date, equalTo: month, toGranularity: .month)
        }
        
        let income = filtered
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
        
        let expense = filtered
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
        
        let balance = income - expense
        
        // Find top spending category
        let expensesByCategory = Dictionary(grouping: filtered.filter { $0.type == .expense }) { $0.category }
        let categoryTotals = expensesByCategory.mapValues { $0.reduce(0) { $0 + $1.amount } }
        let topCategory = categoryTotals.max(by: { $0.value < $1.value })?.key
        
        // Calculate average daily spending
        let daysInMonth = calendar.range(of: .day, in: .month, for: month)?.count ?? 30
        let avgDailySpending = expense / Double(daysInMonth)
        
        return MonthlySummary(
            income: income,
            expense: expense,
            balance: balance,
            topCategory: topCategory,
            transactionCount: filtered.count,
            avgDailySpending: avgDailySpending
        )
    }
    
    func categoryBreakdown(for month: Date = Date()) -> [(category: Category, amount: Double)] {
        let calendar = Calendar.current
        
        let filtered = transactions.filter {
            calendar.isDate($0.date, equalTo: month, toGranularity: .month) && $0.type == .expense
        }
        
        let grouped = Dictionary(grouping: filtered) { $0.category }
        let totals = grouped.mapValues { $0.reduce(0) { $0 + $1.amount } }
        
        return totals.map { ($0.key, $0.value) }.sorted { $0.amount > $1.amount }
    }
}
