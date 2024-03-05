import UIKit

class Parcel {
	let name: String
	var content = [Parcel]()

	init(name: String) {
		self.name = name
	}

	func description() {
		print("This is a \(self.name)")
	}

	func add(parcel: Parcel) {
		self.content.append(parcel)
	}

	func remove(parcel: Parcel) {
		print("Removed \(self.content.removeLast()) from the parcel")
	}

	func checkContents() {
		guard self.content.count > 0 else { return }
		print("This box contain:")
		for parcel in self.content {
			parcel.description()
		}
	}
}

let box = Parcel(name: "Box")
let screenProtector = Parcel(name: "Screen Protector")
let iPhoneCharger = Parcel(name: "iPhone Charger")

box.add(parcel: screenProtector)
box.add(parcel: iPhoneCharger)
box.description()
box.checkContents()
