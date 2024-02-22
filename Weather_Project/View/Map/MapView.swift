//
//  ContentView.swift
//  Unit9_Weather_Project
//
///Entry view of the project, it shows a map pre-centered around Andover, MA.
///It has a search function allows users to search within the U.S. If no search result comes back,
///an alert window will be poped up to notify user.
///
///In the center of the map, there is a + circle, users click on it to pin point a target location to check weather and outfit suggestions.
///Click on + circle, a pin location is shown on the map.
///
import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var viewModel = WeatherViewModel.shared
    @State private var text = ""
    
    var body: some View {

        NavigationView{
            ZStack{
                VStack {
                    TextField("Enter an address in the U.S.", text: $text)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    Button("Find address") {
                        viewModel.textSearch(area: text)
                    }
                    Map(
                        coordinateRegion: $viewModel.region,
                        showsUserLocation: true, annotationItems: viewModel.locations
                    ) {location in
                        MapAnnotation(
                            coordinate: CLLocationCoordinate2D(
                                latitude: location.coordinate.latitude,
                                longitude: location.coordinate.longitude
                            )) {
                                PinView(title: location.name, subtitle: location.name, color: .blue, coordinate: location.coordinate)
                            }
                    }
                }
                Button {
                    viewModel.addLocation()
                } label: {
                    Image(systemName: "plus")
                }
                .padding()
                .background(.blue.opacity(0.3))
                .foregroundColor(.white)
                .font(.title)
                .clipShape(Circle())
                .padding(.trailing)

            }
            .alert(isPresented: $viewModel.showingSearchAlert) {
                Alert(title: Text("No place found in the U.S."),
                      message: Text("Please enter a valid U.S. address"),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
