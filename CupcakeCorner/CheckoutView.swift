//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Denys Nazymok on 06.04.2023.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var confirmationTitle = ""
    @State private var showConfirmationMessage = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                
                
                Text("Your total is: \(order.oneOrder.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(confirmationTitle ,isPresented: $showConfirmationMessage) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Error with encoding")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
                let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationTitle = "Thank Ypu"
            confirmationMessage = "Your order for \(decodedOrder.oneOrder.quantity)x \(Order.types[decodedOrder.oneOrder.type].lowercased()) cupcakes is on its way!"
                showConfirmationMessage = true
        } catch {
            confirmationTitle = "Ooops, we have error"
            confirmationMessage = "Fail to send request"
            showConfirmationMessage = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
