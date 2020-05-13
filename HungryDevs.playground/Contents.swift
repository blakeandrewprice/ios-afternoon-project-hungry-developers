import Foundation

class Spoon {
    private let lock = NSLock()
    let index: Int
    
    init(index: Int) {
        self.index = index
    }
    
    func pickUp() {
        lock.lock()
    }
    
    func putDown() {
        lock.unlock()
    }
}

class Developer {
    let dev: Int
    let leftSpoon: Spoon
    let rightSpoon: Spoon
    
    init(_ num: Int, _ lhS: Spoon, _ rhS: Spoon)
    {
        self.dev = num
        self.leftSpoon = lhS
        self.rightSpoon = rhS
    }
    
    func think() {
        if leftSpoon.index < rightSpoon.index {
            leftSpoon.pickUp()
            print("Dev \(dev) picked up left spoon")
            rightSpoon.pickUp()
            print("Dev \(dev) picked up right spoon")
            print("Dev \(dev) picked up both spoons")
        } else {
            rightSpoon.pickUp()
            print("Dev \(dev) picked up right spoon")
        }
    }
    
    func eat() {
        let eatTime = Int.random(in: 1...100)
        usleep(useconds_t(eatTime))
        print("Dev \(dev) eating for: \(eatTime)")
        rightSpoon.putDown()
        print("Dev \(dev) put down right spoon")
        leftSpoon.putDown()
        print("Dev \(dev) put down left spoon")
    }
    
    func run() {
        while true {
            think()
            eat()
        }
    }
}

let spoon1 = Spoon(index: 1)
let spoon2 = Spoon(index: 2)
let spoon3 = Spoon(index: 3)
let spoon4 = Spoon(index: 4)
let spoon5 = Spoon(index: 5)

let dev1 = Developer(1, spoon1, spoon2)
let dev2 = Developer(2, spoon2, spoon3)
let dev3 = Developer(3, spoon3, spoon4)
let dev4 = Developer(4, spoon4, spoon5)
let dev5 = Developer(5, spoon5, spoon1)

let developers = [dev1, dev2, dev3, dev4, dev5]

DispatchQueue.concurrentPerform(iterations: 5) {
    developers[$0].run()
}
