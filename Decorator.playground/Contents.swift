import UIKit

protocol Text {
	func read()
}

struct NewspaperText: Text {
	func read() {
		print("Blah blah blah")
	}
}

class BaseTextDecorator: Text {
	let wrappee: Text

	init(wrappee: Text) {
		self.wrappee = wrappee
	}

	func read() {
		wrappee.read()
	}
}

class ElectronicNewspaperText: BaseTextDecorator {
	override func read() {
		print("*Reading the text out loud*")
		super.read()
	}
}

class VideoNewspaperText: BaseTextDecorator {
	override func read() {
		print("*Lets find videos of these news*")
		super.read()
	}
}

let someText = NewspaperText()
let textOnNewsSite = ElectronicNewspaperText(wrappee: someText)
let videoNewsBlog = VideoNewspaperText(wrappee: textOnNewsSite)
videoNewsBlog.read()
