//
//  ContentView.swift
//  MidtermDanielPius
//
//  Created by Daniel Pius on 2024-10-17.
//
//TITLE PAGE
//DANIEL PIUS - 991675608

import SwiftUI

//Creates function to init
class Orderlist : ObservableObject{
    @Published var coffeeOrder: [Order] = []
    
    func addCoffeeOrder(size: String, type : String, tip : Bool, numOfCups : Int){
        let createOrder = Order(
            id:coffeeOrder.count+1, //increment by 1 for order id
            size: size,
            type: type,
            tip: tip,
            numOfCups: numOfCups
        )
        coffeeOrder.append(createOrder)
    }
}

//Class Order which sets the all the vars
class Order : Identifiable, ObservableObject{
    @Published var id : Int
    @Published var size : String
    @Published var type : String
    @Published var tip : Bool
    @Published var numOfCups : Int
    
    init(id : Int, size: String, type: String, tip: Bool, numOfCups: Int) {
        self.id = id
        self.size = size
        self.type = type
        self.tip = tip
        self.numOfCups = numOfCups
    }
}

//Main Page UI
struct ContentView: View {
    //Create Stored Properties
    @StateObject var orderList = Orderlist()
    
    //User Order Name
    @State private var tfName : String = ""
    
    //toggle on/ off
    @State var isOn = false
    
    //Size Options
    let coffeeSizes = ["Small", "Medium", "Large"]
    @State private var selectedSize = "Small"
    
    //Type Options
    let coffeeTypes = ["Dark Roast", "Original Blend", "Vanilla"]
    @State private var selectedType = "Small"
    
    //Add Tip
    @State private var addedTip : Bool = false
    
    //total Cups Options
    @State private var totalCups : Int = 0
    
    //Number Formatter object
    private let numberFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.generatesDecimalNumbers = false
        formatter.zeroSymbol = ""
        return formatter
    }()
    
    var body: some View {
        NavigationView{
            VStack (alignment: .leading, spacing: 20){
                Text("Order a Coffee")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .principal){
                        VStack{
                            Text("Daniel Pius").font(.headline)
                        }
                    }
                }
                .foregroundColor(Color.black)
                .font(.title)
                .bold()
                
                Form{
                    Section(header: Text("Your Name")){
                        //House Price Input
                        TextField("Name: ", text: self.$tfName)
                    }
                    //Choose Coffee Size UI
                    Section(header: Text("Select Coffee Size")){
                        Picker("Size: ", selection: $selectedSize){
                            ForEach(coffeeSizes, id: \.self){
                                Text($0)
                            }
                        }
                    }.pickerStyle(.segmented)
                    
                    Section(header: Text("Select Coffee Type")){
                        Picker("Size: ", selection: $selectedType){
                            ForEach(coffeeTypes, id: \.self){
                                Text($0)
                            }
                        }
                    }.pickerStyle(.segmented)
                    
                    Section(header: Text("Would you like to add a $2 tip?")){
                        Toggle(isOn: $isOn){
                            Text("Add Tip")
                        }
                    }
                    
                    Section(header: Text("Number of Cups")){
                        //House Price Input
                        TextField("Enter Number of Cups: ", value: self.$totalCups, formatter: numberFormatter)
                    }
                    
                    //Complete Order UI Button
                    Section(header: Text("Complte Order")){
                        Button(action: {
                            //Add Function call to add order
                            orderList.addCoffeeOrder(
                                size: selectedSize,
                                type: selectedType,
                                tip: true,
                                numOfCups: totalCups)
                        }) {
                            Text("Add Order")
                        }
                    }
                    
                    NavigationLink(destination: SummaryView(orderList: orderList, coffeeOrder: orderList.coffeeOrder)){
                        Text("Show Orders")
                    }
                }
            }
            
        }
        
            }
}

#Preview {
    ContentView()
}
