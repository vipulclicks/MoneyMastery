
//  Created by Vipul Kumar Singh on 19/01/26.
//
//  CategoryChart.swift
//  MiniFinanceTracker
//

import SwiftUI
import Charts

struct CategoryChart: View {
    let data: [(category: Category, amount: Double)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Spending by Category")
                .font(.headline)
            
            if data.isEmpty {
                Text("No expenses this month")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 40)
            } else {
                Chart(data, id: \.category) { item in
                    BarMark(
                        x: .value("Amount", item.amount),
                        y: .value("Category", item.category.rawValue)
                    )
                    .foregroundStyle(item.category.color)
                }
                .frame(height: CGFloat(data.count * 40))
                .chartXAxis {
                    AxisMarks(position: .bottom)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    CategoryChart(data: [
        (.food, 450.00),
        (.travel, 320.00),
        (.shopping, 180.00)
    ])
    .padding()
}
