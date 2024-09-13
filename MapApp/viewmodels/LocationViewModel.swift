//
//  LocationViewModel.swift
//  MapApp
//
//  Created by oktay on 8.09.2024.
//

import Foundation
import MapKit
import SwiftUI

class LocationViewModel: ObservableObject {
    
    @Published var locations: [Location]
    
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    
    @Published var showLocationList: Bool = false
    
    @Published var sheetLocation:Location? = nil 
    
    init() {
        
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location:Location) {
        withAnimation(.easeOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
            span: mapSpan)
            
        }
    }
    
    public func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }
    public func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
                mapLocation = location
            showLocationList = false
        }
    }
    
    func nextBtnPressed(){
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Not Found Index for nextBtnPressed func")
            return
        }
        let nexIndex = currentIndex + 1
        guard locations.indices.contains(nexIndex) else {
            guard let first = locations.first else {return}
            showNextLocation(location: first)
            return
        }
        let nextLocation = locations[nexIndex]
        showNextLocation(location: nextLocation)
    }
}
