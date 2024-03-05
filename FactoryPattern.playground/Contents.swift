import UIKit

protocol Food {
	func eat()
	var cost: Int { get }
}

class Pancake: Food {
	func eat() {
		print("😋");
	}
	
	var cost = 40
}

class RottenApple: Food {
	func eat() {
		print("🤢");
	}
	
	var cost = 20
}

protocol LocalShopSeller {
	func buyFoodWith(money: Int) -> Food?
}

class LocalShop: LocalShopSeller {
	func buyFoodWith(money: Int) -> Food? {
		switch money {
		case (0..<20):
			print("Need more gold")
			return nil
		case (20..<40):
			print("Take an apple")
			let apple = RottenApple()
			return apple
		default:
			print("Take pancakes")
			let pancake = Pancake()
			return pancake
		}
	}
}

let localShop = LocalShop()
var somethingToEat = localShop.buyFoodWith(money: 0)
somethingToEat?.eat()
somethingToEat = localShop.buyFoodWith(money: 20)
somethingToEat?.eat()
somethingToEat = localShop.buyFoodWith(money: 40)
somethingToEat?.eat()
