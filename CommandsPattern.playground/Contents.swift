import UIKit

/// Commands Pattern

// MARK: - Receiver
class Door {
  
  private(set) var isOpen: Bool = false {
    didSet {
      print(isOpen ? "Door is now opened" : "Door is now closed")
    }
  }
  
  func open() {
    guard !isOpen else { return }
    
    sleep(1)
    isOpen = true
  }
  
  func close() {
    guard isOpen else { return }
    
    sleep(1)
    isOpen = false
  }
  
}

// MARK: - Commands

protocol Command {
  func execute()
}

class OpenDoorCommand: Command {
  
  weak var door: Door?
  
  func execute() {
    door?.open()
  }
  
}

class CloseDoorCommand: Command {
  
  weak var door: Door?
  
  func execute() {
    door?.close()
  }
  
}

// MARK: - Invoker

class Doorman {
  
  let door = Door()
  var commands: [Command] = []
  
  func work() {
    let openCommand = OpenDoorCommand()
    let closeCommand = CloseDoorCommand()
    openCommand.door = door
    closeCommand.door = door
    commands = [openCommand, closeCommand, openCommand, closeCommand]
    
    commands.forEach { $0.execute() }
  }
  
}

let doorman = Doorman()
doorman.work()
