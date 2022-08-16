//
//  Wine.swift
//  Vino mio
//
//  Created by Hailey Matzen on 8/2/22.
//

import Foundation
import FirebaseFirestoreSwift

// Attributes
// Identifiable can make me to use the attributes in my WineLibraryView.
struct Wine: Identifiable, Codable{
    // It helps whenever we map from a document into Wine, firestore reads the document id of the document and map it into this id attribute.
//    @DocumentID var id: String? = UUID().uuidString
    @DocumentID var id: String?
    var userId: String?
    var name: String
    var country: String
    var region: String
    var grapes: String
    var producer: String
//    var year: Int
    var year: String
//    var ABV: Int
    var ABV: String
    var visualsIntensity: String
    var type: String
    var color: String
    var aromasIntensity: String
    var aromas: String
    var sweetness: String
    var acidity: String
    var alcohol: String
    var tannin: String
    var body: String
    var flavors: String
    var finish: String
    var quality: String
    var additionalComments: String
    var image: UIImage = UIImage()
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case name
        case country
        case region
        case grapes
        case producer
        case year
        case ABV
        case visualsIntensity
        case type
        case color
        case aromasIntensity
        case aromas
        case sweetness
        case acidity
        case alcohol
        case tannin
        case body
        case flavors
        case finish
        case quality
        case additionalComments
        case imageUrl
    }
}
