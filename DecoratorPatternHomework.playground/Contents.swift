import Foundation

// Model

struct Ingredient {
  
  var name: String
  
  init(name: String) {
    self.name = name
  }
  
}

typealias Euro = Double

// Protocols

protocol CupOfCoffee {
  var ingredients: [Ingredient] { get }
  var cupCost: Euro { get }
}

protocol CoffeeIngredient: CupOfCoffee {
  var ingredient: Ingredient { get }
  var additionalCost: Euro { get }
  var source: CupOfCoffee { get }
  
  init(to source: CupOfCoffee)
}

extension CoffeeIngredient {
  
  var ingredients: [Ingredient] {
    var newIngredients = source.ingredients
    newIngredients.append(ingredient)
    return newIngredients
  }
  
  var cupCost: Euro {
    return source.cupCost + additionalCost
  }
}

// Cups

class Shot: CupOfCoffee {
  
  var ingredients: [Ingredient] = []
  
  var cupCost: Euro = 0.5
  
}

class SmallCup: CupOfCoffee {
  
  var ingredients: [Ingredient] = []
  
  var cupCost: Euro = 1.0
  
}

class MediumCup: CupOfCoffee {
  
  var ingredients: [Ingredient] = []
  
  var cupCost: Euro = 1.5
  
}

class LargeCup: CupOfCoffee {
  
  var ingredients: [Ingredient] = []
  
  var cupCost: Euro = 2.0
  
}

// Extras

class Water: CoffeeIngredient {
  
  var source: CupOfCoffee

  required init(to source: CupOfCoffee) {
    self.source = source
  }
  
  var ingredient: Ingredient {
    let water = Ingredient(name: "Water")
    return water
  }
  
  var additionalCost: Euro {
    return 1
  }
  
}

class Coffee: CoffeeIngredient {
  
  var source: CupOfCoffee
  
  required init(to source: CupOfCoffee) {
    self.source = source
  }
  
  var ingredient: Ingredient {
    let coffee = Ingredient(name: "Coffee")
    return coffee
  }
  
  var additionalCost: Euro {
    return 2
  }
  
}

// Beverages
let shot = Shot()
print("Current cup cost: \(shot.cupCost)€\nYour cup includes: \(shot.ingredients)\n-----")
let shotWithWater = Water(to: shot)
print("Current cup cost: \(shotWithWater.cupCost)€\nYour cup includes: \(shotWithWater.ingredients)\n-----")
let shotWithWaterAndCoffee = Coffee(to: shotWithWater)
print("Current cup cost: \(shotWithWaterAndCoffee.cupCost)€\nYour cup includes: \(shotWithWaterAndCoffee.ingredients)\n-----")
