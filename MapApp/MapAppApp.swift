//
//  MapAppApp.swift
//  MapApp
//
//  Created by oktay on 8.09.2024.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var vModel = LocationViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView().environmentObject(vModel)
        }
    }
}
