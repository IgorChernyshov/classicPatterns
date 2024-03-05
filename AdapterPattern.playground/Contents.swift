import UIKit

protocol Balance {
	func showBalance()
	var sum: Float { get }
}

protocol BalanceAdapter {
	func showBalanceToUser()
	var sum: String { get }
}

class Wallet: Balance {
	func showBalance() {
		print("\(sum)")
	}
	
	var sum: Float
	
	init(sum: Float) {
		self.sum = sum
	}
}

class ATM: BalanceAdapter {
	func showBalanceToUser() {
		let balance = sum.replacingOccurrences(of: "000", with: "k")
		print("\(balance)")
	}
	
	var sum: String
	
	init(wallet: Wallet) {
		sum = String(wallet.sum)
	}
}

let wallet = Wallet(sum: 1000)
wallet.showBalance()
let atm = ATM(wallet: wallet)
atm.showBalanceToUser()
