//
//  DatabaseConn.swift
//  WalletApp
//
//  Created by Vitoroi Daniel on 05.03.2024.
//

import Foundation
import SQLite

class DatabaseConnection {
    static let shared = DatabaseConnection()
    private let db: Connection
    
    private let users = Table("users")
    private let id = Expression<Int64>("id")
    private let firstName = Expression<String>("first_name")
    private let lastName = Expression<String>("last_name")
    private let email = Expression<String>("email")
    private let password = Expression<String>("password")
    
    private init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
            ).first!
            db = try Connection("\(path)/db.sqlite3")
            createTable()
        } catch {
            fatalError("Error connecting to database: \(error)")
        }
    }
    
    private func createTable() {
        do {
            try db.run(users.create { table in
                table.column(id, primaryKey: true)
                table.column(firstName)
                table.column(lastName)
                table.column(email, unique: true)
                table.column(password)
            })
        } catch {
            print("Error creating table: \(error)")
        }
    }
    
    func addUser(firstName: String, lastName: String, email: String, password: String) {
        do {
            try db.run(users.insert(self.firstName <- firstName, self.lastName <- lastName, self.email <- email, self.password <- password))
        } catch {
            print("Error inserting user: \(error)")
        }
    }
    
    func getUser(email: String) -> Row? {
        do {
            let query = users.filter(self.email == email)
            return try db.pluck(query)
        } catch {
            print("Error fetching user: \(error)")
            return nil
        }
    }
    
    func verifyUser(email: String, password: String) -> Bool {
        if let user = getUser(email: email) {
            let storedPassword = String(user[self.password])
            return storedPassword == password
        }
        return false
    }
}
