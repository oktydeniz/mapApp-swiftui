//
//  LocationPreview.swift
//  MapApp
//
//  Created by oktay on 11.09.2024.
//

import SwiftUI

struct LocationPreview: View {
    
    @EnvironmentObject private var vm: LocationViewModel
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(spacing:16) {
                imageSection
                titleSection
            }
            VStack(alignment: .leading,spacing:8) {
                learnMoreBtn
                nextBtn
            }
        }.padding(20)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y:65))
            .cornerRadius(10)
    }
}

extension LocationPreview {
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName).resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection : some View {
        VStack(alignment: .leading, spacing: 4){
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(location.cityName)
                .font(.subheadline)
            
        }.frame(maxWidth:.infinity, alignment: .leading)
    }
    
    private var learnMoreBtn : some View {
        Button(action: {
            vm.sheetLocation = location
        }, label: {
            Text("Learn More").font(.headline).frame(width: 125, height: 35)
        }).buttonStyle(.borderedProminent)
    }
    
    private var nextBtn : some View {
        Button(action: {
            vm.nextBtnPressed()
        }, label: {
            Text("Next").font(.headline).frame(width: 125, height: 35)
        }).buttonStyle(.bordered)
    }
}

