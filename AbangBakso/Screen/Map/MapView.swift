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
    @StateObject var mapVM = ViewModelProvider.shared.createMapViewModel()
    
    @State var position = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -6.222328, longitude: 106.812764),
        span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
    )
    
    var body: some View {
        Map(coordinateRegion: $position, annotationItems: mapVM.customers) { cust in
            MapAnnotation(coordinate: cust.coordinate) {
                Marker(name: cust.name)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            setInitialPosition()
            mapVM.startObservingCustomers()
        }
        .onDisappear {
            
            mapVM.stopObservingCustomers()
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
    MapView(user: User(type: .seller, [:]))
}
