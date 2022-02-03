//
//  Spherical Bessel Functions.swift
//  HW 2 Bessel Funcs
//
//  Created by Michael Cardiff on 2/2/22.
//

import SwiftUI

/// downwardRecurseBessel
/// - Parameters:
///   - x: compute the function at this value
///   - order: Current order, lowered in recursion
///   - start: Desired computed order
func downwardRecurseBessel(x: Double, order: Int, start: Int) -> Double {
    //        2l + 1
    // j    = ------ j (x) - j   (x)
    //  l-1      x    l       l+1
    
    var scale = sphericalBesselZero(x: x) // scaling term
    var jl = Array(repeating: 0.0, count: start + 2) // jl[i] = j_i
    
    jl[start+1] = 1.0 // start with a guess
    jl[ start ] = 1.0 // start with a guess
    
    for i in (1...start).reversed() { // Downward, start with highest order
        // implementation of above formula for a particular x value
        jl[i-1] = (((2.0 * Double(i) + 1.0) / x) * jl[i]) - jl[i+1]
    }
    
    scale = scale / jl[0]; // normalize value
    
    return (jl[order])*scale
}

/// upwardRecurseBessel
/// - Parameters:
///   - x: compute the function at this value
///   - order: Current order, raised in recursion
///   - start: Desired computed order
func upwardRecurseBessel(x: Double, order: Int) -> Double {
    //        2l + 1
    // j    = ------ j (x) - j   (x)
    //  l+1      x    l       l-1
    
    var j0 = sphericalBesselZero(x: x)
    var j1 = 0.0 // temporary until we verify order > 0
    var ret = 0.0
    
    if (order == 0) {
        // asked for the first j0
        ret = j0
    } else if (order == 1) {
        ret = sphericalBesselOne(x: x)
    } else { // asked for something we can recurse up to
        j1 = sphericalBesselOne(x: x)
        for i in (1..<order) { // Upward
            // implementation of recursion relation
            ret = ((2.0 * Double(i) + 1.0) / x) * j1 - j0
            
            // change used values
            j0 = j1
            j1 = ret
        }
    }
    
    return ret
}

/// sphericalBesselZero
/// - Parameter x: compute at this value
/// - Returns: j0(x)
func sphericalBesselZero(x: Double) -> Double {
    //         sin(x)
    // j (x) = ------
    //  0        x
    
    let ret = sin(x)/(x)
    return ret
}


/// sphericalBesselOne
/// - Parameter x: compute at this value
/// - Returns: j1(x)
func sphericalBesselOne(x: Double) -> Double {
    //         sin(x)   cos(x)
    // j (x) = ------ - ------
    //  1       x^2        x

    let term1 = sin(x)/(pow(x,2))
    let term2 = cos(x)/x
    let ret = term1 - term2
    
    return ret
}

