//
// PinView.swift
//
/// This view presents a pin, each pin allows users to delete the pin or check weather of the pinned location
/// The implementaiton is referenced from this post:
///https://stackoverflow.com/questions/71445019/adding-callout-to-pin-in-swiftui-map
///
import SwiftUI
import MapKit

struct PinView: View {
    @State private var showCallout = false
    @ObservedObject var viewModel = WeatherViewModel.shared
    let title: String
    let subtitle: String?
    let color: UIColor
    let coordinate: CLLocationCoordinate2D
    @Binding var isSelected: Bool?
    
    init(title: String, subtitle: String? = nil, color: UIColor, coordinate: CLLocationCoordinate2D, isSelected: Binding<Bool?> = .constant(nil)) {
        self.title = title
        self.subtitle = subtitle
        self.color = color
        self.coordinate = coordinate
        self._isSelected = isSelected
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "exclamationmark.circle.fill")
                .font(.title)
                .foregroundColor(Color(uiColor: color))
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(Color(uiColor: color))
                .offset(x: 0, y: -5)
            
            VStack {
                Text("Delete")
                    .font(.callout)
                    .foregroundColor(.red)
                    .onTapGesture {
                        viewModel.removeLocation(loc: Location(name: "", coordinate: coordinate))
                    }
                
                NavigationLink(destination: ForeCastView(coordinate: coordinate)) {
                              Text("check weather")
                                  .padding()
                          }
            }
            .background(Color(.white))
            .cornerRadius(10)
            .opacity(showCallout ? 1 : 0)
        }
        .onTapGesture {
            showCallout.toggle()
        }
        .onLongPressGesture {
            if let _ = isSelected {
                self.isSelected!.toggle()
            }
        }
    }
}
