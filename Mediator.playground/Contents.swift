import UIKit

protocol Developer: AnyObject {
  func pull(developers developer: Developer, commit: String)
}

protocol Git: AnyObject {
  func addDeveloper(_ developer: Developer)
  func receiveCommit(_ commit: String, from developer: Developer)
}

class GitHub: Git {
  
  var developers: [Developer] = []
  
  func addDeveloper(_ developer: Developer) {
    developers.append(developer)
  }
  
  func receiveCommit(_ commit: String, from developer: Developer) {
    for receiver in developers where receiver !== developer {
      receiver.pull(developers: developer, commit: commit)
    }
  }
  
}

class Person {
  
  let name: String
  private weak var git: Git?
  
  init(name: String, git: Git) {
    self.name = name
    self.git = git
    git.addDeveloper(self)
  }
  
  func pushCommit(_ commit: String) {
    print("\(self.name) pushed commit \(commit)")
    self.git?.receiveCommit(commit, from: self)
  }
  
}

extension Person: Developer {
  
  func pull(developers developer: Developer, commit: String) {
    print("\(name) pulled commit \(commit)")
  }
  
}

let gitHub = GitHub()
let developer1 = Person(name: "Igor Chernyshov", git: gitHub)
let developer2 = Person(name: "Egor Tolstoy", git: gitHub)
let developer3 = Person(name: "Evgeniy Elchev", git: gitHub)

developer1.pushCommit("feature/homework1")
developer3.pushCommit("merged feature/homework1 into master")
