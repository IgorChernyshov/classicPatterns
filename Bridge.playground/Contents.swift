import UIKit

// MARK: Interface
class Driver {
	var vehicle: Vehicle

	init(vehicle: Vehicle) {
		self.vehicle = vehicle
	}

	func toggleIgnition() {
		vehicle.engineRunning = !vehicle.engineRunning
	}

	func fuelVehicle(liters: Float) {
		vehicle.addFuel(liters: liters)
	}

	func accelerate(power: Float) {
		vehicle.pressAcceleratePedal(power: power)
	}

	func deccelerate(power: Float) {
		vehicle.pressDeacceleratePedal(power: power)
	}
}

// MARK: Implementation

protocol Vehicle {
	var engineRunning: Bool { get set }
	var currentSpeed: Float { get }
	var maximumSpeed: Float { get }
	var currentFuel: Float { get }
	var maximumFuel: Float { get }
	func startEngine()
	func stopEngine()
	func addFuel(liters: Float)
	func pressAcceleratePedal(power: Float)
	func pressDeacceleratePedal(power: Float)
	func drive()
}

class Car: Vehicle {
	var engineRunning = false
	var currentSpeed: Float = 0.0
	var maximumSpeed: Float = 220.0
	var currentFuel: Float = 0.0
	var maximumFuel: Float = 60.0

	func startEngine() {
		if currentFuel > 0.0 {
			engineRunning = true
			print("Meh meh broom!")
		} else {
			print("Meh meh meh meh")
		}
	}

	func stopEngine() {
		if engineRunning {
			engineRunning = false
		}
	}

	func addFuel(liters: Float) {
		if currentFuel < maximumFuel {
			currentFuel = max(maximumFuel, currentFuel + liters)
			print("Car says \"Thank you\"!")
		} else {
			print("I cannot fit anymore")
		}
	}

	func pressAcceleratePedal(power: Float) {
		// Why not? :D No rocket science here
		if power <= 0.0 || power > 1.0 {
			print("Board Computer: Incorrect pedal input")
			return
		}
		if engineRunning == false
		{
			print("Squeek")
			return
		}

		if currentFuel >= power {
			currentFuel -= power
			currentSpeed = max(maximumSpeed, currentSpeed + power)
			if power <= 0.5 {
				print("Wrooom")
			} else if power > 0.5 {
				print("WROOOOOOM!")
			}
			drive()
		} else if currentFuel <= power {
			currentSpeed += currentFuel
			currentFuel = 0.0
			engineRunning = false
			print("Meh meh meh")
		}
	}

	func pressDeacceleratePedal(power: Float) {
		if power <= 0.0 || power > 1.0 {
			print("Board Computer: Incorrect pedal input")
			return
		}
		if currentSpeed == 0.0 || engineRunning == false {
			print("We're not going anywhere")
			return
		}
		currentSpeed = max(0.0, currentSpeed - power)
		print("Eek")
		drive()
	}

	func drive() {
		if currentSpeed == 0.0 || engineRunning == false {
			print("We're not going anywhere")
			return
		}
		currentFuel -= currentSpeed / 1000
		print("Are we there yet?")
	}
}

let bmw = Car()
let me = Driver(vehicle: bmw)
me.accelerate(power: 1.0)
me.toggleIgnition()
me.accelerate(power: 1.0)
me.fuelVehicle(liters: 10.0)
me.toggleIgnition()
me.accelerate(power: 1.0)
me.accelerate(power: 1.0)
me.deccelerate(power: 1.0)
me.deccelerate(power: 1.0)
me.toggleIgnition()
