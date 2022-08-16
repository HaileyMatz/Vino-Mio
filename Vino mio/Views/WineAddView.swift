//
//  WineEditView.swift
//  Vino mio
//
//  Created by Hailey Matzen on 8/3/22.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct WineAddView: View {
    
    var winesViewModel: WinesViewModel
    @State var userId = UserDefaults.standard.value(forKey: "userId") as? String
    @StateObject var viewModel: WineViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    @State var retrievedImages = [UIImage]()
    
    @State private var visualIntensityListIndex = 0
    @State private var typeListIndex = 0
    @State private var aromaIntensityListIndex = 0
    @State private var sweetnessListIndex = 0
    @State private var acidityListIndex = 0
    @State private var alcoholListIndex = 0
    @State private var tanninListIndex = 0
    @State private var bodyListIndex = 0
    @State private var finishListIndex = 0
    @State private var qualityListIndex = 0
    @State private var redListIndex = 0
    @State private var whiteListIndex = 0
    @State private var roseListIndex = 0
    
    var visualIntensityList = ["", "Light", "Medium", "Deep"]
    var typeList = ["", "Red", "White", "Rosé", "Sparkling", "Dessert"]
    var aromaIntensityList = ["", "Light", "Medium", "Strong"]
    var sweetnessList = ["", "Dry", "Off-dry", "Medium", "Sweet"]
    var acidityList = ["", "Low", "Medium", "High"]
    var alcoholList = ["", "Low", "Medium", "High"]
    var tanninList = ["", "Low", "Medium", "High"]
    var bodyList = ["", "Light", "Medium", "Full"]
    var finishList = ["", "Short", "Medium", "Long"]
    var qualityList = ["", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    var redList = ["", "Purple", "Ruby", "Garnet", "Tawny"]
    var whiteList = ["", "Gold", "Amber", "Lemon"]
    var roseList = ["", "Pink", "Pink Orange", "Orange"]
    
    var body: some View {
        NavigationView {
            VStack {
                    HStack {
                        if typeListIndex == 1 {
                            Image("redWine")
                                .resizable()
                                .frame(width: 140, height: 140)
                                .clipShape(RoundedRectangle(cornerRadius: 70))
                                .scaledToFit()
                        } else if typeListIndex == 2 {
                            Image("whiteWine")
                                .resizable()
                                .frame(width: 140, height: 140)
                                .clipShape(RoundedRectangle(cornerRadius: 70))
                                .scaledToFit()
                        } else if typeListIndex == 3 {
                            Image("roseWine")
                                .resizable()
                                .frame(width: 140, height: 140)
                                .clipShape(RoundedRectangle(cornerRadius: 70))
                                .scaledToFit()
                        } else if typeListIndex == 4 {
                            Image("sparklingWine")
                                .resizable()
                                .frame(width: 140, height: 140)
                                .clipShape(RoundedRectangle(cornerRadius: 70))
                                .scaledToFit()
                        } else if typeListIndex == 5 {
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

                }

                Form {
                    Section(header: Text("Bottle Info")) {
                        TextField("Product Name", text: $viewModel.wine.name)
                        TextField("Country", text: $viewModel.wine.country)
                        TextField("Region", text: $viewModel.wine.region)
                        TextField("Grapes", text: $viewModel.wine.grapes)
                        TextField("Producer", text: $viewModel.wine.producer)
                        TextField("Year", text: $viewModel.wine.year)
                        TextField("ABV%", text: $viewModel.wine.ABV)
                    }

                    Section(header: Text("Visuals")) {
                        Picker(
                            selection: $visualIntensityListIndex,
                            label: Text("Intensity")) {
                                ForEach(0 ..< visualIntensityList.count, id: \.self) { index in
                                    Text(self.visualIntensityList[index]).tag(index)
                                }
                            }
                            .onChange(of: visualIntensityListIndex) { index in
                                viewModel.wine.visualsIntensity = visualIntensityList[index]
                            }
                        Picker(
                            selection: $typeListIndex,
                            label: Text("Types")) {
                                ForEach(0 ..< typeList.count, id: \.self) { index in
                                    Text(self.typeList[index]).tag(index)
                                }
                            }
                            .onChange(of: typeListIndex) { index in
                                viewModel.wine.type = typeList[index]
                            }
                        if typeListIndex == 1 {
                            Picker(
                                selection: $redListIndex,
                                label: Text("Color")) {
                                    ForEach(0 ..< redList.count, id: \.self) {index in
                                        Text(self.redList[index]).tag(index)
                                    }
                                }
                        } else if typeListIndex == 2 {
                            Picker(
                                selection: $whiteListIndex,
                                label: Text("Color")) {
                                    ForEach(0 ..< whiteList.count, id: \.self) {index in
                                        Text(self.whiteList[index]).tag(index)
                                    }
                                }
                        } else if typeListIndex == 3 {
                            Picker(
                                selection: $roseListIndex,
                                label: Text("Color")) {
                                    ForEach(0 ..< roseList.count, id: \.self) {index in
                                        Text(self.roseList[index]).tag(index)
                                    }
                                }
                        
                    }
                    }
                    Section(header: Text("Aromas")) {
                        Picker(
                            selection: $aromaIntensityListIndex,
                            label: Text("Intensity")) {
                                ForEach(0 ..< aromaIntensityList.count, id: \.self) { index in
                                    Text(self.aromaIntensityList[index]).tag(index)
                                }
                            }
                            .onChange(of: aromaIntensityListIndex) { index in
                                viewModel.wine.aromasIntensity = aromaIntensityList[index]
                            }
                        TextField("Aromas", text: $viewModel.wine.aromas)
                    }
                    Section(header: Text("Palate")) {
                        Picker(
                            selection: $sweetnessListIndex,
                            label: Text("Sweetness")) {
                                ForEach(0 ..< sweetnessList.count, id: \.self) { index in
                                    Text(self.sweetnessList[index]).tag(index)
                                }
                            }
                            .onChange(of: sweetnessListIndex) { index in
                                viewModel.wine.sweetness = sweetnessList[index]
                            }
                        Picker(
                            selection: $acidityListIndex,
                            label: Text("Acidity")) {
                                ForEach(0 ..< acidityList.count, id: \.self) { index in
                                    Text(self.acidityList[index]).tag(index)
                                }
                            }
                            .onChange(of: acidityListIndex) { index in
                                viewModel.wine.acidity = acidityList[index]
                            }
                        Picker(
                            selection: $alcoholListIndex,
                            label: Text("Alcohol")) {
                                ForEach(0 ..< alcoholList.count, id: \.self) { index in
                                    Text(self.alcoholList[index]).tag(index)
                                }
                            }
                            .onChange(of: alcoholListIndex) { index in
                                viewModel.wine.alcohol = alcoholList[index]
                            }
                        if typeListIndex == 1 {
                        Picker(
                            selection: $tanninListIndex,
                            label: Text("Tannin(red only)")) {
                                ForEach(0 ..< tanninList.count, id: \.self) { index in
                                    Text(self.tanninList[index]).tag(index)
                                }
                            }
                            .onChange(of: tanninListIndex) { index in
                                viewModel.wine.tannin = tanninList[index]
                            }
                        }
                        Picker(
                            selection: $bodyListIndex,
                            label: Text("Body")) {
                                ForEach(0 ..< bodyList.count, id: \.self) { index in
                                    Text(self.bodyList[index]).tag(index)
                                }
                            }
                            .onChange(of: bodyListIndex) { index in
                                viewModel.wine.body = bodyList[index]
                            }
                        TextField("Flavors", text: $viewModel.wine.flavors)

                        Picker(
                            selection: $finishListIndex,
                            label: Text("Finish")) {
                                ForEach(0 ..< finishList.count, id: \.self) { index in
                                    Text(self.finishList[index]).tag(index)
                                }
                            }
                            .onChange(of: finishListIndex) { index in
                                viewModel.wine.finish = finishList[index]
                            }
                    }
                    Section(header: Text("Overall Rating")) {
                        Picker(
                            selection: $qualityListIndex,
                            label: Text("Quality")) {
                                ForEach(0 ..< qualityList.count, id: \.self) { index in
                                    Text(self.qualityList[index]).tag(index)
                                }
                            }
                            .onChange(of: qualityListIndex) { index in
                                viewModel.wine.quality = qualityList[index]
                            }
                        TextField("Additional Comments", text: $viewModel.wine.additionalComments)

                    }
                }
            } // VStack line 46
            .navigationBarTitle("New Wine", displayMode: .inline)
            .navigationBarItems(
                leading: Button (action: { handleCancelTapped() }, label: {
                    Text("Cancel")
                        .foregroundColor(Color("Color"))
                }),
                trailing: Button(action: { handleDoneTapped() }, label: {
                    Text("Done")
                        .foregroundColor(Color("Color"))
                })
                .disabled(!viewModel.modified)
            )
        } // NavigationView line 45
} // var body line 44
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func handleDoneTapped() {
        viewModel.save(userId: userId!)
        if viewModel.wine.id == nil {
            winesViewModel.fetchData(userId: userId!)
        } else {
            winesViewModel.fetchWine(wineId: viewModel.wine.id! )
        }
        dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
} // struct line 12

struct WineEditView_Previews: PreviewProvider {
    static var previews: some View {
        WineAddView(winesViewModel: WinesViewModel.init(), viewModel: WineViewModel())
    }
}
