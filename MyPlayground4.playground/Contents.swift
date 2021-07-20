import UIKit

struct Person {
    var name: String = ""
    
    mutating func setName(n: String) {
        name = n
    }
}

var adrian: Person = Person()
adrian.setName(n: "adrian")
//adrian.name = "adrian"
print(adrian.name)


let ewa: Person = Person()
//ewa.setName(n: "ewa")
print(ewa.name)

//adrian = ewa
