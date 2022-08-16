//
//  WineViewModel.swift
//  Vino mio
//
//  Created by Hailey Matzen on 8/3/22.
//

import Foundation
import Firebase
import Combine


// Hold my wine lists
class WineViewModel: ObservableObject {
    
    @Published var wine: Wine
    @Published var modified = false
    
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
    
    init(wine: Wine = Wine(name: "", country:"", region:"", grapes:"", producer:"", year: "", ABV: "", visualsIntensity: "", type: "", color:"", aromasIntensity: "", aromas: "", sweetness: "", acidity: "", alcohol: "", tannin: "", body:"", flavors: "", finish: "", quality: "", additionalComments: "", image: UIImage(), imageUrl: "")) {
        
        self.wine = wine
        
        self.$wine
            .dropFirst()
            .sink { [weak self] wine in
                self?.modified = true
                
            }
            .store(in: &cancellables)
    }
    
    func addWine() {
        do {
            let _ = try db.collection("wines").addDocument(from: self.wine)
        }
        catch {
            print(error)
        }
    }
    
    func save(userId: String) {
        wine.userId = userId
        if wine.id != nil {
           self.updateWine()
       } else {
           self.addWine()
                }
    }

    func updateWine() {
        if let documentId = wine.id {
            do {
                try
                db.collection("wines").document(documentId).setData(from: self.wine)
            }
            catch {
                print(error)
            }
        }
    }
 
}
