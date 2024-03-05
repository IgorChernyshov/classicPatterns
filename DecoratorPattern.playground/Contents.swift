import UIKit

protocol Character {
  var health: Double { get }
}

class Human: Character {
  
  var health: Double {
    return 50.0
  }
  
}

class Elf: Character {
  
  var health: Double {
    return 40.0
  }
  
}

class Dwarf: Character {
  
  var health: Double {
    return 75.0
  }
  
}

class Orc: Character {
  
  var health: Double {
    return 60.0
  }
  
}

protocol CharacterDecorator: Character {
  var source: Character { get }
  init(source: Character)
}

class Champion: CharacterDecorator {
  
  var source: Character
  var health: Double {
    return source.health * 5
  }
  
  required init(source: Character) {
    self.source = source
  }
  
}

class Veteran: CharacterDecorator {
  
  var source: Character
  var health: Double {
    return source.health * 10
  }
  
  required init(source: Character) {
    self.source = source
  }
  
}

let human = Human()
print(human.health)
let orc = Orc()
print(orc.health)
let dwarf = Dwarf()
print(dwarf.health)
let humanChampion = Champion(source: human)
print(humanChampion.health)
let orcVeteran = Veteran(source: orc)
print(orcVeteran.health)
let dwarfChampionVeteran = Champion(source: Veteran(source: dwarf))
print(dwarfChampionVeteran.health)
