//
//  main.swift
//  homework-1.month-6
//
//  Created by Islam Erlan Uulu on 24/7/23.
//

import Foundation

protocol PaymentStrategy {
    func pay(amount: Double)
}

class DebitCardPaymentStrategy: PaymentStrategy {
    func pay(amount: Double) {
        print("Оплата дебитовой картой: \(amount)сом")
    }
}

class MbankQRPaymentStrategy: PaymentStrategy {
    func pay(amount: Double) {
        print("Оплата через MbankQR: \(amount)сом")
    }
}

// Класс использующий стратегию оплаты
class PaymentContext {
    private var paymentStrategy: PaymentStrategy
    
    init(paymentStrategy: PaymentStrategy) {
        self.paymentStrategy = paymentStrategy
    }
    
    func setPaymentStrategy(_ paymentStrategy: PaymentStrategy) {
        self.paymentStrategy = paymentStrategy
    }
    
    func processPayment(amount: Double) {
        paymentStrategy.pay(amount: amount)
    }
}

// Протокол для Адаптер
protocol OldPaymentSystem {
    func oldPay(amount: Double)
}

// Старая система оплаты
class OldPaymentSystemImpl: OldPaymentSystem {
    func oldPay(amount: Double) {
        print("Старая система оплаты: $\(amount)")
    }
}

// Адаптер для использования старой системы оплаты с новой системой
class PaymentSystemAdapter: PaymentStrategy {
    private let oldPaymentSystem: OldPaymentSystem
    
    init(oldPaymentSystem: OldPaymentSystem) {
        self.oldPaymentSystem = oldPaymentSystem
    }
    
    func pay(amount: Double) {
        oldPaymentSystem.oldPay(amount: amount)
    }
}

// Использование паттернов

let debitCardPaymentStrategy = DebitCardPaymentStrategy()
let mBankqrPaymentStrategy = MbankQRPaymentStrategy()

let paymentContext = PaymentContext(paymentStrategy: debitCardPaymentStrategy)


paymentContext.processPayment(amount: 100.0)


paymentContext.setPaymentStrategy(mBankqrPaymentStrategy)
paymentContext.processPayment(amount: 50.0)


let oldPaymentSystem = OldPaymentSystemImpl()


let adapter = PaymentSystemAdapter(oldPaymentSystem: oldPaymentSystem)


let adapterContext = PaymentContext(paymentStrategy: adapter)

adapterContext.processPayment(amount: 75.0)


