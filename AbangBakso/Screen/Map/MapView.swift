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
    @StateObject var mapVM: MapViewModel
    
    @State var showDialog: Bool = false
    @State var position = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -6.222328, longitude: 106.812764),
        span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
    )
    
    @Environment(\.scenePhase) private var scenePhase
    
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            mapView
            closeButton
        }
        .edgesIgnoringSafeArea(.all)
        .overlay(confirmDialog)
        .onAppear {
            setInitialPosition()
            mapVM.startObservingCustomers()
            mapVM.startObservingLocation()
        }
        .onDisappear {
            mapVM.stopObserving()
            mapVM.setOnline(false)
        }
        .onChange(of: scenePhase, { oldValue, newValue in
            switch newValue {
            case .active:
                mapVM.setOnline(true)
            case .background:
                mapVM.setOnline(false)
            default:
                print("no action for \(newValue)")
            }
        })
        .onChange(of: mapVM.user, { oldValue, newValue in
            if oldValue != nil && newValue == nil {
                loginVM.destroySession()
            }
        })
    }
    
    private var mapView: some View {
        Map(coordinateRegion: $position, showsUserLocation: true, annotationItems: mapVM.customers) { cust in
            
            MapAnnotation(coordinate: cust.coordinate) {
                CustomMarker(type: cust.type, name: cust.name)
            }
        }
    }
    
    private var closeButton: some View {
        Button {
            showDialog = true
        } label: {
            Image("close_icon")
                .frame(width: 24, height: 24)
        }.padding(50)
    }
    
    private var confirmDialog: some View {
        ConfirmationDialog(isShowing: $showDialog) {
            mapVM.destroySession()
        }
        .opacity(showDialog ? 1 : 0)
        .animation(.easeInOut(duration: 0.3), value: showDialog)
            
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
    MapView(user: User(type: .seller, [:]), mapVM: ViewModelProvider.shared.createMapViewModel(for: .customer))
}
