//
//  AdressView.swift
//  CupcakeCorner
//
//  Created by Denys Nazymok on 06.04.2023.
//

import SwiftUI

struct AdressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.oneOrder.name)
                TextField("Street", text: $order.oneOrder.street)
                TextField("City", text: $order.oneOrder.city)
                TextField("ZIP", text: $order.oneOrder.zip)
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.oneOrder.hasValidAdress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AdressView_Previews: PreviewProvider {
    static var previews: some View {
        AdressView(order: Order())
    }
}
