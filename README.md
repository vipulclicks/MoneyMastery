# 💸 MoneyMastery – Mini Finance Tracker

A clean, SwiftUI-based personal finance tracker for iOS that helps users manage daily income and expenses with powerful monthly analytics.

> Ideal for demonstrating SwiftUI, MVVM architecture, and local data persistence in iOS apps.

---

## ✨ Features

- ✅ Add income & expenses with categories  
- 📊 Visual spending analytics using Swift Charts  
- 📅 Monthly summary with balance tracking  
- 🎯 Category-wise expense breakdown  
- 💾 Persistent local storage  
- 🌙 Dark mode support  
- 🗑️ Swipe to delete transactions  

---

## 📸 Screenshots

> Screenshots will be added once UI polish is finalized.

| Home Screen | Add Transaction | Analytics |
|------------|-----------------|-----------|
| *Monthly summary & balance* | *Quick entry form* | *Category breakdown* |

---

## 🏗 Architecture

Built with **MVVM (Model-View-ViewModel)** architecture for clean separation of concerns:
```
📱 App Layer
  ├── Views (SwiftUI)
  │     └── Observes → ViewModel
  ├── ViewModels (Business Logic)
  │     └── Uses → Models + Services
  ├── Models (Data Layer)
  │     └── Codable structs
  └── Services (Persistence)
        └── FileManager + JSON
```

## 🛠 Tech Stack

- **Language**: Swift 5.9+
- **UI Framework**: SwiftUI
- **Charts**: Swift Charts (iOS 16+)
- **Architecture**: MVVM
- **Storage**: FileManager + JSON (Codable)
- **Minimum iOS**: 16.0

## 🔧 Technical Highlights

### Why MVVM?
- Clear separation between UI and business logic
- Testable ViewModels independent of UI
- Scalable for future features (CloudKit, widgets, etc.)

### Why FileManager over UserDefaults?
- UserDefaults has a 4MB practical limit
- JSON files enable future export/backup features
- Easier migration path to CoreData/CloudKit
- Better for handling growing transaction lists

### Why Swift Charts?
- Native iOS 16+ framework with zero dependencies
- Smooth animations and interactions out-of-the-box
- Consistent with Apple's design language
- Better performance than third-party libraries

## 📊 Key Features Breakdown

### Monthly Analytics
- **Total Income/Expense/Balance**: Real-time calculations
- **Top Spending Category**: Identifies highest expense category
- **Average Daily Spending**: Helps track spending patterns
- **Category Breakdown**: Visual chart showing expense distribution

### Data Persistence
```swift
// Custom persistence layer using FileManager
class PersistenceManager {
    func save(_ transactions: [Transaction]) throws
    func load() -> [Transaction] throws
    func delete() throws
}
```

### Computed Properties
```swift
var formattedAmount: String // Currency formatting
var formattedDate: String   // Human-readable dates
var isValidInput: Bool      // Input validation
```

## 🚀 Future Enhancements

If I continue this project, here's what I'd add:

- [ ] CoreData migration for complex queries
- [ ] CloudKit sync across devices
- [ ] Recurring transactions support
- [ ] Multi-currency support
- [ ] Budget alerts and notifications
- [ ] CSV export functionality
- [ ] Widgets for home screen
- [ ] Receipt photo attachments

## 📚 What I Learned

1. **State Management**: Mastered `@StateObject`, `@ObservedObject`, and `@Published` for reactive UI updates
2. **Data Persistence**: Implemented custom JSON-based file storage with proper error handling
3. **Swift Charts**: Integrated native charting framework for compelling data visualizations
4. **MVVM in Practice**: Separated concerns effectively for testability and maintainability
5. **Date Handling**: Leveraged Calendar API for monthly aggregations and filtering
6. **SwiftUI Best Practices**: Proper use of @Environment, sheets, alerts, and navigation

## 🎯 Project Context

This project was built as a portfolio piece to demonstrate:
- iOS development fundamentals
- Clean architecture patterns
- Real-world problem solving
- Understanding of financial app mechanics

It serves as a foundation for my larger vision: **FinstraFi** - a comprehensive financial services platform.

## 📦 Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/MiniFinanceTracker.git
```

2. Open in Xcode
```bash
cd MiniFinanceTracker
open MiniFinanceTracker.xcodeproj
```

3. Run on simulator or device (iOS 16.0+)

## 🤝 Contributing

This is a learning project, but feedback and suggestions are welcome! Feel free to open issues or submit PRs.

## 📄 License

MIT License - feel free to use this code for learning purposes.

---

**Built with ❤️ using SwiftUI**

