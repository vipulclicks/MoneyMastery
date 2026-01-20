//
//  PersistenceManager.swift
//  MiniFinanceTracker
//
//  Created by Vipul Kumar Singh on 19/01/26.

import Foundation

enum PersistenceError: Error {
    case fileNotFound
    case encodingFailed
    case decodingFailed
    case saveFailed
}

class PersistenceManager {
    static let shared = PersistenceManager()
    
    private init() {}
    
    private let fileURL: URL = {
        let documentsPath = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
        return documentsPath.appendingPathComponent("transactions.json")
    }()
    
    func save(_ transactions: [Transaction]) throws {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(transactions)
            try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
        } catch {
            throw PersistenceError.saveFailed
        }
    }
    
    func load() throws -> [Transaction] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let transactions = try decoder.decode([Transaction].self, from: data)
            return transactions
        } catch {
            throw PersistenceError.decodingFailed
        }
    }
    
    func delete() throws {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return
        }
        try FileManager.default.removeItem(at: fileURL)
    }
}
