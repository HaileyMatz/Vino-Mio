//
//  WineLibraryView.swift
//  Vino mio
//
//  Created by Hailey Matzen on 8/2/22.
//

import SwiftUI

struct WineCollectionsView: View {
    @ObservedObject private var viewModel = WinesViewModel()
    @State private var presentAddNewWineScreen = false
    @State private var presentAddWineDetailScreen = false
    @State private var presentLogOutButton = false
    @State private var logOut = false
    @State var userId = UserDefaults.standard.value(forKey: "userId") as? String

    var body: some View {

            NavigationView {
            
            // iterate over the wines
            List{
                ForEach(viewModel.wines) {wine in
                NavigationLink {
                    WineDetailView(wineId: wine.id!)
                } label: {
                    HStack{
                        if wine.type == "Red" {
                            Image("redWine")
                                .resizable()
                                .frame(width:50, height: 50)
                                .aspectRatio(contentMode: .fit)

                        } else if wine.type == "White" {
                            Image("whiteWine")
                                .resizable()
                                .frame(width:50, height: 50)
                                .aspectRatio(contentMode: .fit)
                        } else if wine.type == "Rosé" {
                            Image("roseWine")
                                .resizable()
                                .frame(width:50, height: 50)
                                .aspectRatio(contentMode: .fit)
                        } else if wine.type == "Sparkling" {
                            Image("sparklingWine")
                                .resizable()
                                .frame(width:50, height: 50)
                                .aspectRatio(contentMode: .fit)
                        } else if wine.type == "Dessert" {
                            Image("dessertWine")
                                .resizable()
                                .frame(width:50, height: 50)
                                .aspectRatio(contentMode: .fit)
                        } else {
                            Image("none")
                                .resizable()
                                .frame(width:50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .aspectRatio(contentMode: .fit)
                        }

                        Text("\(wine.name)")
                            .font(.system(size: 18, weight: .bold))
                    }
                }
                }
                .onDelete(perform: self.viewModel.deleteWine)

            }
            .navigationBarTitle("My Wine Collections")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { logOut.toggle() }, label: {
                        Text("Log Out")
                            .font(.subheadline)
                            .foregroundColor(Color("Color"))
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { presentAddNewWineScreen.toggle() }, label: {
                        Image(systemName: "plus")
                            .font(.subheadline)
                            .foregroundColor(Color("Color"))
                    })
                }
            }
            .sheet(isPresented: $presentAddNewWineScreen) {
                WineAddView(winesViewModel: self.viewModel, viewModel: WineViewModel())
            }
            .sheet(isPresented: $logOut) {
                HomeScreen()
            }
            .onAppear() {
                self.viewModel.fetchData(userId: userId!)
            }
        }
    }

}

