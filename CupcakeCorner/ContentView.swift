//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Denys Nazymok on 06.04.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cupcake type", selection: $order.oneOrder.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(order.oneOrder.quantity)", value: $order.oneOrder.quantity, in: 3...20)
                }
                .navigationTitle("Cupcake Corner")
                
                Section {
                    Toggle("Any special requests?", isOn: $order.oneOrder.specialRequestEnabled.animation())
                    
                    if order.oneOrder.specialRequestEnabled {
                        Toggle("Add extra frostings", isOn: $order.oneOrder.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.oneOrder.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery details") {
                        AdressView(order: order)
                    }
                }
            }
        }
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
