//
//  main.swift
//  RetainCycles
//
//  Created by Guilherme Wahlbrink on 2019-05-23.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import Foundation

// Strong and Weak Pointer

// Strong RC + 1

// Weak RC + 0

class Apartment {
    let unit: String
    weak var tenant: Person?
    init(unit: String) {
        self.unit = unit
        print("Apartment \(unit) is being initialized")
    }
    
    deinit {
        print("\(unit) is killed")
    }
}

class Person {
    let name: String
    var apartment: Apartment?
    // when creating an instance
    init(name: String){
        self.name = name
        print("\(name) is being initialized")
    }
    
    // when getting deinitialized
    deinit {
        print("\(name) is killed")
    }
}

var tom: Person?
var waterfront: Apartment?

tom = Person(name: "Tom")
waterfront = Apartment(unit: "123A")

tom!.apartment = waterfront

waterfront!.tenant = tom

tom = nil
waterfront = nil

// Both were not killed due to strong pointers

// How to resolve this problem?

// "weak" pointer (won't increment ref count)





//var person1: Person?
//var person2: Person?
//
//person1 = Person(name: "Tom")
//person2 = person1
//person1 = nil

// even that person1 is being killed it will still be in memory due to person2



// strong, weak, unowned
// weak - Optional ( can be nil)
//      - delegate (weak)

// Unowned Reference
// Like a weak reference, an unowned reference does not
// keep a strong hold on the instnace it refers to.
// Unlike a weak reference, unowed reference is used
// when the other instance has the same lifetime or a longer lifetime.


// Use an unowned reference only when you are sure that the
// reference always refers to an instnace that has not been deallocated.

// Customer(Person) ---- CreditCard

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
        print("CreditCard #\(number) is being initialized")
    }
    
    deinit {
        print("CreditCard #\(number) is being deinitialized")
    }
}

class Customer {
    let name: String
    var card: CreditCard?
    
    init(name: String){
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}


var tom2: Customer?
tom2 = Customer(name: "Tom")
tom2?.card = CreditCard(number: 123451231823, customer: tom2!)

tom = nil


// Retain cycles for Closures (Reference Type)


class HTMLElement {
    let name: String // p
    let text: String? // some paragraph
    // <p> some paragrah </p>
    
    lazy var asHTML: () -> String = { [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name)/>"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}


var heading: HTMLElement? = HTMLElement(name: "h1", text: "Welcome to my website")


print(heading!.asHTML())

heading = nil


