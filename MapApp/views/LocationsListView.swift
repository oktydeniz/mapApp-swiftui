//
//  LocationsListView.swift
//  MapApp
//
//  Created by oktay on 9.09.2024.
//

import SwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject private var vm: LocationViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                Button(action: {
                    vm.showNextLocation(location: location)
                }) {
                    listRowView(location: location)
                }.padding(.vertical, 4)
                    .listRowBackground(Color.clear)
            }
        }.listStyle(PlainListStyle())
    }
}


extension LocationsListView {
    
    private func listRowView(location:Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName).resizable().scaledToFit().frame(width: 45, height: 45).cornerRadius(10)
            }
            VStack(alignment: .leading) {
                Text(location.name).font(.headline)
                Text(location.cityName).font(.subheadline)
            }.frame(width: .infinity, alignment: .leading)
        }
    }
}
