import UIKit

// Models
class SwiftCode {
	var code = String()

	init(code: String) {
		self.code = code
	}
}

class ObjcCode {
	var code = String()

	init(code: String) {
		self.code = code
	}
}

// Service
class SwiftCompiler {
	func compileCode(swiftCode: SwiftCode) {
		print("Successfully compiled code: \(swiftCode.code)")
	}
}

// Adapter
class SwiftCompilerAdapter {
	var adaptee: SwiftCompiler

	init(adaptee: SwiftCompiler) {
		self.adaptee = adaptee
	}

	func compileCode(objcCode: ObjcCode) {
		objcCode.code = objcCode.code.replacingOccurrences(of: "[", with: "")
		objcCode.code = objcCode.code.replacingOccurrences(of: "]", with: "")
		objcCode.code = objcCode.code.replacingOccurrences(of: ";", with: "")
		let swiftCode = SwiftCode(code: objcCode.code)
		adaptee.compileCode(swiftCode: swiftCode)
	}
}

// Client
let objcCode = ObjcCode(code: "[[ShittyCode alloc] init];")
let swiftCompiler = SwiftCompiler()
let shittyCodeAdapter = SwiftCompilerAdapter(adaptee: swiftCompiler)
shittyCodeAdapter.compileCode(objcCode: objcCode)
