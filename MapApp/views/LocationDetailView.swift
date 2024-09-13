//
//  LocationDetailView.swift
//  MapApp
//
//  Created by oktay on 11.09.2024.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @EnvironmentObject private var vm: LocationViewModel
    let location: Location
    var body: some View {
        ScrollView {
            VStack {
                tabs
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x:0, y:10)
                VStack(alignment: .leading, spacing: 16){
                    title
                    Divider()
                    desctiptionSection
                    Divider()
                    map
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
        }.ignoresSafeArea()
            .background(.ultraThinMaterial)
            .overlay(backButton, alignment: .topLeading)
    }
}


extension LocationDetailView {
    
    private var tabs : some View {
        TabView {
            ForEach(location.imageNames,id: \.self) {img in
                Image(img)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    .clipped()
            }
        }.frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    private var title: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(location.name).font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var desctiptionSection: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            if let url = URL(string: location.link) {
                Link("Read more on wikipedia", destination: url).tint(.blue).font(.headline)
            }
        }
    }
    
    private var map: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
            annotationItems: [location]) { l in
            MapAnnotation(coordinate: l.coordinates) {
                LocationMapAnnotationView().shadow(radius: 10)
            }
        }.allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)
    }
    
    private var backButton : some View {
        Button(action: {
            vm.sheetLocation = nil
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .background(.thickMaterial)
                .foregroundColor(.primary)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        })
    }
}
