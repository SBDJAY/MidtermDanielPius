//
//  SummaryView.swift
//  MidtermDanielPius
//
//  Created by Daniel Pius on 2024-10-17.
//
//TITLE PAGE
//DANIEL PIUS - 991675608
import SwiftUI

struct SummaryView: View {
    @ObservedObject var orderList : Orderlist
    
    var coffeeOrder: [Order]
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Coffee Order list!")
                    .font(.title)
                    .bold()
                    .padding()
                
                List(orderList.coffeeOrder){
                    order in
                    VStack(alignment: .leading){
                        Text("Order Number #\(order.id)")
                            .font(.headline)
                        Text("Size: \(order.size)")
                        Text("Topping: \(order.type)")
                        Text("Added Tip: \(order.tip)")
                        Text("Number of Cups: \(order.numOfCups)")
                    }
                    
                    .padding()
                }
            }
        }
    }
}
#Preview {
    SummaryView(orderList: Orderlist(), coffeeOrder: [])
}
