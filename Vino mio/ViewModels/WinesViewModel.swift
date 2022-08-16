//
//  WineLibrariesViewModel.swift
//  Vino mio
//
//  Created by Hailey Matzen on 8/2/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

// Hold collection of wines
class WinesViewModel: ObservableObject {
    
    @Published var wines = [Wine]()
    @Published var wine: Wine? = nil
    
    private var db = Firestore.firestore()
    
    
    func fetchWine(wineId: String) {
        db.collection("wines").document(wineId)
            .getDocument { (document, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let document = document, document.exists {
                        self.wine = try? document.data(as: Wine.self)
                    }
                }
            }
    }
    
    func fetchData(userId: String) {
//         get our collections
//        querySnapshot holds the documents from my collection
        db.collection("wines").whereField("userId", isEqualTo: userId)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    
                    if let snapshot = snapshot {
                        
                        self.wines = snapshot.documents.compactMap { doc in
                            
                            var wine = try? doc.data(as: Wine.self)
                            if wine != nil {
                                wine!.id = doc.documentID
                            }
                            return wine
                        }
                    }
                }
            }
    }

    func deleteWine(at offsets: IndexSet) {

        offsets.forEach { offset in
            let wine = wines[offset]
            guard let wineId = wine.id else {return}
            db.collection("wines").document(wineId).delete() {err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed")
                    
                    self.wines.remove(at: offset)
                        
                }
            }
        }
    }
    
}
