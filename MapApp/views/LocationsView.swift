//
//  LocationsView.swift
//  MapApp
//
//  Created by oktay on 8.09.2024.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vModel: LocationViewModel
    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        ZStack {
            map.ignoresSafeArea()
            VStack(spacing:0) {
                header.padding()
                    .frame(maxWidth:maxWidthForIpad)
                    .frame(maxWidth:.infinity)
                Spacer()
                marker
            }
        }.sheet(item: $vModel.sheetLocation, onDismiss: nil) { loc in
            LocationDetailView(location: loc)
        }
    }
}

extension LocationsView {
    
    private var marker : some View {
        ZStack {
            ForEach(vModel.locations) { l in
                if vModel.mapLocation == l {
                    LocationPreview(location: l)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        //.transition(AnyTransition.opacity.animation(.easeOut))
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
    
    private var header: some View {
        VStack {
            Button(action: vModel.toggleLocationList){
                Text(vModel.mapLocation.name + ", " + vModel.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height:55)
                
                .frame(maxWidth:.infinity)
                .animation(.none, value: vModel.mapLocation)
                .overlay(alignment: .leading) {
                    Image(systemName: "arrow.down").font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                        .rotationEffect(Angle(degrees: vModel.showLocationList ? 180 : 0))
                }
            }
            if vModel.showLocationList {
                LocationsListView()
            }
           
        }.background(.thickMaterial)
            .cornerRadius(10)
            .shadow(color:Color.black.opacity(0.3), radius:20,x:0, y:15)
    }
    
    private var map: some View {
        Map(coordinateRegion: $vModel.mapRegion,
            annotationItems: vModel.locations,
            annotationContent: {l in
            MapAnnotation(coordinate: l.coordinates) {
                LocationMapAnnotationView().scaleEffect(vModel.mapLocation == l ? 1 : 0.7)
                    .shadow(radius: 10).onTapGesture {
                        vModel.showNextLocation(location: l)
                    }
            }
        })
    }
}
