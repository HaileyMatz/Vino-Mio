//
//  WineDetailView.swift
//  Vino mio
//
//  Created by Hailey Matzen on 8/3/22.
//

import SwiftUI


struct WineDetailView: View {
    
    @ObservedObject private var viewModel = WinesViewModel()
    @State private var goBackToMainLibrary = false
    @State var userId = UserDefaults.standard.value(forKey: "userId") as? String
    @State var presentEditWine = false
    @StateObject var editModel = WineViewModel()
    var wineId: String
    
    private func EditButton(action: @escaping () -> Void) -> some View {
        Button(action: {
            self.editModel.wine = self.viewModel.wine!
            presentEditWine.toggle()
        }) {
            Text("Edit")
        }
        .sheet(isPresented: $presentEditWine) {
            WineAddView(winesViewModel: self.viewModel, viewModel: editModel)
        }
        .onAppear() {
            self.viewModel.fetchData(userId: userId!)
        }
    }
    
    var body: some View {
          
        VStack {
            
            if let wine = viewModel.wine  {
                if wine.type == "Red" {
                    Image("redWine")
                        .resizable()
                        .frame(width: 140, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 70))
                        .scaledToFit()
                } else if wine.type == "White" {
                    Image("whiteWine")
                        .resizable()
                        .frame(width: 140, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 70))
                        .scaledToFit()
                }  else if wine.type == "Rosé" {
                    Image("roseWine")
                        .resizable()
                        .frame(width: 140, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 70))
                        .scaledToFit()
                } else if wine.type == "Sparkling" {
                    Image("sparklingWine")
                        .resizable()
                        .frame(width: 140, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 70))
                        .scaledToFit()
                } else if wine.type == "Dessert" {
                    Image("dessertWine")
                        .resizable()
                        .frame(width: 140, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 70))
                        .scaledToFit()
                } else {
                    Image("none")
                        .resizable()
                        .frame(width: 140, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 70))
                        .scaledToFit()
                } 
                Form {

                        Section("Bottle Info"){
                            Text("Name : \(wine.name)")
                                .font(.body)
                            Text("Country : \(wine.country)")
                                .font(.body)
                            Text("Region : \(wine.region)")
                                .font(.body)
                            Text("Grapes : \(wine.grapes)")
                                .font(.body)
                            Text("Producer : \(wine.producer)")
                                .font(.body)
                            Text("Year : \(wine.year)")
                                .font(.body)
                            Text("ABV% : \(wine.ABV)%")
                                .font(.body)
                        }

                        Section("Visuals"){
                            Text("Intensity : \(wine.visualsIntensity)")
                                .font(.body)
                            Text("Type : \(wine.type)")
                                .font(.body)
                            Text("Color : \(wine.color)")
                                .font(.body)
                        }

                        Section("Aromas") {
                            Text("Intensity : \(wine.aromasIntensity)")
                                .font(.body)
                            Text("Aromas : \(wine.aromas)")
                            .font(.body)
                        }

                        Section("Palate") {
                            Text("Sweetness : \(wine.sweetness)")
                                .font(.body)
                            Text("Acidity: \(wine.acidity)")
                                .font(.body)
                            Text("Alcohol: \(wine.alcohol)")
                                .font(.body)
                            Text("Tannin(red only) : \(wine.tannin)")
                                .font(.body)
                            Text("Body: \(wine.body)")
                                .font(.body)
                            Text("Flavors : \(wine.flavors)")
                                .font(.body)
                            Text("Finish : \(wine.finish)")
                                .font(.body)
                        }

                        Section("Overall Rating") {
                            Text("quality: \(wine.quality)")
                                .font(.body)
                            Text("additional Comments: \(wine.additionalComments)")
                                .font(.body)
                        }
                    }
           
            } else {
                Text("Wine not found")
            }
        }
        .navigationBarTitle("My Wine Details", displayMode: .inline)
        .navigationBarItems(trailing: EditButton {
            self.presentEditWine.toggle()
        })
        .onAppear() {
            self.viewModel.fetchWine(wineId: self.wineId)
        }
        }
    
}
