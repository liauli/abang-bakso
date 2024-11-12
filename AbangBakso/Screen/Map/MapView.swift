//
//  MapView.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 11/11/24.
//

import SwiftUI
import MapKit
import Combine

// MARK: Sample
struct LocationAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
}

struct MapView: View {
    var user: User
    @State var position = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456),
        span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
    )
    
    let annotations = [
            LocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456), title: "Custom Marker")
        ]
    
    var body: some View {
        Map(coordinateRegion: $position, annotationItems: annotations) { annotation in
            MapAnnotation(coordinate: annotation.coordinate) {
                Marker(name: annotation.title)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            setInitialPosition()
            
        }
    }
    
    private func setInitialPosition() {
        position = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: user.location.latitude, longitude: user.location.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        )
    }
}

#Preview {
    MapView()
}
