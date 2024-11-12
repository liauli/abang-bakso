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
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        Map(coordinateRegion: $position, showsUserLocation: true, annotationItems: mapVM.customers) { cust in
            
            MapAnnotation(coordinate: cust.coordinate) {
                CustomMarker(name: cust.name)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            setInitialPosition()
            mapVM.startObservingCustomers()
            mapVM.startObservingLocation()
        }
        .onDisappear {
            mapVM.stopObserving()
            mapVM.setOnline(false)
            
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
               mapVM.setOnline(true)
            case .background:
                mapVM.setOnline(false)
            default:
                print("no action")
            }
        }
    }
    
    private func setInitialPosition() {
        mapVM.user = user
        position = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: user.location.latitude, longitude: user.location.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        )
    }
}

#Preview {
    MapView(user: User(type: .seller, [:]))
}
