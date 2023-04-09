//
//  Order.swift
//  CupcakeCorner
//
//  Created by Denys Nazymok on 06.04.2023.
//

import SwiftUI

class Order: ObservableObject, Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published var oneOrder = OneOrder()
    
    enum CodingKeys: CodingKey {
        case order
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        oneOrder = try container.decode(OneOrder.self, forKey: .order)
        
    }
    
    init() {}
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(oneOrder, forKey: .order)
    }
}
    
    struct OneOrder: Codable {
        
        var type = 0
        var quantity = 3
        
        var specialRequestEnabled = false {
            didSet {
                if specialRequestEnabled == false {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
        var extraFrosting = false
        var addSprinkles = false
        
        var name = ""
        var street = ""
        var city = ""
        var zip = ""
        
        var hasValidAdress: Bool {
            if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || street.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return false
            }
            return true
        }
        
        var cost: Double {
            // $2 per cake
            var cost = Double(quantity) * 2
            
            // complicated cakes cost more
            cost += (Double(type) / 2)
            
            // $1/cake for extra frosting
            if extraFrosting {
                cost += Double(quantity)
            }
            
            // $0.50/cake for sprinkles
            if addSprinkles {
                cost += Double(quantity) / 2
            }
            
            return cost
        }
    }
