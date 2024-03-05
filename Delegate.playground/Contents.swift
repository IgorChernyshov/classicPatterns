import UIKit

protocol BorschDelegate: AnyObject {
    func wantToEat() -> Bool
}

class Granny {
    weak var delegate: BorschDelegate?
    
    func makeLunch() {
        print("Granny is cooking brosch") // direct dispatch
        
        guard let willEatBorsch = delegate?.wantToEat() /* witness dispatch */ else { return }
        
        if willEatBorsch {
            washDishes() // message dispatch
        } else {
            putBorschIntoFridge() // table dispatch
        }
        
        print("Granny is taking a rest") // direct dispatch
    }
    
    @objc func washDishes() {
        print("Granny is washing dishes") // direct dispatch
    }
    
    func putBorschIntoFridge() {
        print("Granny puts borsch into the fridge") // direct dispatch
    }
}

class Grandson: BorschDelegate {
    func wantToEat() -> Bool {
        let grandsonIsHungry = Int.random(in: 0...1) == 1
        
        if grandsonIsHungry {
            print("Grandson is hungry and will eat with pleasure") // direct dispatch
        } else {
            print("Grandson is not hungry but Granny doesn't care") // direct dispatch
        }
        
        eatBorsch() // direct dispatch
        return true
    }
    
    final func eatBorsch() {
        print("Grandson eats borsch") // direct dispatch
    }
}

let granny = Granny()
let grandson = Grandson()

granny.delegate = grandson // table dispatch

granny.makeLunch() // table dispatch
