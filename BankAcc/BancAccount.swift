//
//  BancAccount.swift
//  BankAcc
//
//  Created by Дмитрий Яновский on 17.03.24.
//

import Foundation

class BankAccount {
    var balance: Double = 0
    private let accessQueue = DispatchQueue(label: "accessQueue")
    
    func deposit(amount: Double) {
        accessQueue.async {
            self.balance += amount
            print("Депозит на сумму \(amount) успешно завершен. Баланс: \(self.balance)")
        }
    }
    
    func withdraw(amount: Double) {
        accessQueue.async {
            guard self.balance >= amount else {
                print("Недостаточно средств на счете для снятия \(amount)")
                return
            }
            self.balance -= amount
            print("Снятие наличных на сумму \(amount) успешно завершено. Баланс: \(self.balance)")
        }
    }
    
    func test() {
        
        let account = BankAccount()
        
        let queue1 = DispatchQueue(label: "queue1")
        let queue2 = DispatchQueue(label: "queue2")
        
        queue1.async {
            account.deposit(amount: 200)
            
        }
        
        queue2.async {
            account.withdraw(amount: 150)
        
        }
        
        queue1.async {
            account.withdraw(amount: 30)
        }
        
        queue2.async {
            account.deposit(amount: 200)
        }
    }
}
