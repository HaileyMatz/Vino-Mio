//
//  Vino_mioApp.swift
//  Vino mio
//
//  Created by Hailey Matzen on 7/29/22.
//

import SwiftUI
import Firebase

@main
struct Vino_mioApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
