//
//  ContentView.swift
//  Shared
//
//  Created by Michael Cardiff on 2/2/22.
//

import SwiftUI

struct ContentView: View {
    @State var guess = ""
    @State private var totalInput: Int? = 25 // initial input in bottom bar
    
    private var intFormatter: NumberFormatter =
    {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return f
    }()
    
    var body: some View {
        VStack {
            // output and button
            HStack {
                // text editor to contain input and output
                TextEditor(text: $guess)
                
                // button to start calculations
                Button("Calculate Spherical Bessel Functions",
                action: calculateSphBesselFunc)
            }
            .frame(minHeight: 300, maxHeight: 800)
            .frame(minWidth: 480, maxWidth: 800)
            .padding()
            
            // Input for order
            HStack {
                Text(verbatim: "Order:")
                    .padding()
                TextField("Total",
                          value: $totalInput,
                          formatter: intFormatter)
                    .padding()
            }
        }
    }
    
    func calculateSphBesselFunc() {
        // constants
        let xvals = [0.1, 1.0, 10.0]
        let orderMax = totalInput ?? 0 // order to compute up to
        var test = false
        guess = ""
        
        // test values
        // not implemented yet
        let analyticVals =
        [[ 9.518519719e-6,  9.616310231e-10, 2.901200102e-16],
         [ 9.006581118e-3,  9.256115862e-5 , 2.826498802e-8 ],
         [-3.949584498e-1, -5.553451162e-1 , 1.255780236e0  ]]
        
        for order in (0...orderMax) {
            let start = order + 25 // highest order in downward
            guess += String(format: "j%d(x)\n", order)
            if(order == 3 || order == 5 || order == 8) { test = true }
            for x in xvals {
                let downVal = downwardRecurseBessel(x: x, order: order, start: start)
                let upVal   = upwardRecurseBessel(x: x, order: order)
                let errVal  = abs(upVal - downVal) / abs(upVal) + abs(downVal)
                
                if(test) {
                    
                }
                
                // display x, down recursion, up recursion, and relative error
                guess += String(
                    format: "x = %f, Dn: %7.5e, Up: %7.5e, Err: %7.5e\n",
                    x, downVal, upVal, errVal
                )
            }
            test = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
