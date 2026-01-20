
//  Created by Vipul Kumar Singh on 19/01/26.
//
//  HomeView.swift
//  MiniFinanceTracker
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: TransactionViewModel
    @State private var showingAddTransaction = false
    @State private var showingClearAlert = false
    
    var summary: MonthlySummary {
        viewModel.monthlySummary(for: viewModel.selectedMonth)
    }
    
    var categoryData: [(category: Category, amount: Double)] {
        viewModel.categoryBreakdown(for: viewModel.selectedMonth)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Month Selector
                    monthSelector
                    
                    // Summary Cards
                    summaryCards
                    
                    // Category Chart
                    if !categoryData.isEmpty {
                        CategoryChart(data: categoryData)
                            .padding(.horizontal)
                    }
                    
                    // Recent Transactions
                    recentTransactions
                }
                .padding(.vertical)
            }
            .navigationTitle("Finance Tracker")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddTransaction = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
                
                ToolbarItem(placement: .secondaryAction) {
                    Menu {
                        NavigationLink {
                            TransactionListView()
                        } label: {
                            Label("All Transactions", systemImage: "list.bullet")
                        }
                        
                        Divider()
                        
                        Button(role: .destructive) {
                            showingClearAlert = true
                        } label: {
                            Label("Clear All Data", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .sheet(isPresented: $showingAddTransaction) {
                AddTransactionView()
            }
            .alert("Clear All Data?", isPresented: $showingClearAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Clear", role: .destructive) {
                    viewModel.clearAllData()
                }
            } message: {
                Text("This will permanently delete all transactions. This action cannot be undone.")
            }
        }
    }
    
    // MARK: - Components
    
    private var monthSelector: some View {
        HStack {
            Button {
                withAnimation {
                    viewModel.selectedMonth = Calendar.current.date(
                        byAdding: .month,
                        value: -1,
                        to: viewModel.selectedMonth
                    ) ?? viewModel.selectedMonth
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
            }
            
            Spacer()
            
            Text(viewModel.selectedMonth.monthYearString)
                .font(.title2)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button {
                withAnimation {
                    viewModel.selectedMonth = Calendar.current.date(
                        byAdding: .month,
                        value: 1,
                        to: viewModel.selectedMonth
                    ) ?? viewModel.selectedMonth
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title3)
            }
        }
        .padding(.horizontal)
    }
    
    private var summaryCards: some View {
        VStack(spacing: 12) {
            // Balance Card
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Balance")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(summary.formattedBalance)
                        .font(.title)
                        .fontWeight(.bold)
                }
                Spacer()
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            // Income & Expense
            HStack(spacing: 12) {
                // Income
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Image(systemName: "arrow.down.circle.fill")
                            .foregroundColor(.green)
                        Text("Income")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Text(summary.formattedIncome)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Expense
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Image(systemName: "arrow.up.circle.fill")
                            .foregroundColor(.red)
                        Text("Expense")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Text(summary.formattedExpense)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }
        }
        .padding(.horizontal)
    }
    
    private var recentTransactions: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Recent Transactions")
                    .font(.headline)
                
                Spacer()
                
                NavigationLink {
                    TransactionListView()
                } label: {
                    Text("See All")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            
            if viewModel.currentMonthTransactions.isEmpty {
                Text("No transactions this month")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 40)
            } else {
                ForEach(viewModel.currentMonthTransactions.prefix(5)) { transaction in
                    TransactionRow(transaction: transaction)
                        .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(TransactionViewModel())
}
