//
//  WeeklyOutfitView.swift
//
///
///This view allows users to horizontally scroll  5 day's outfit suggesions.
///The page indicator comes from:
///https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-scrolling-pages-of-content-using-tabviewstyle
///
///When the view is loaded, it displays a default set of data for both weather and outfit.  While it waits for viewModel
///to retrieve data from APIs, placeholder images are displayed.  If data retrieval is successful, actual images and data
///are displayed.  If API call fails, then a alert window pops up to notify user. 
///
///Placeholder of a view is referenced from this aritcle:
///https://betterprogramming.pub/using-placeholders-while-loading-data-in-swiftui-ef6e4b8782bb
///
import SwiftUI
import MapKit

struct WeeklyOutfitView: View {
    @ObservedObject var viewModel = WeatherViewModel.shared
    let coordinate: CLLocationCoordinate2D
    
    var body: some View {
        TabView {
            ForEach((0...4), id: \.self) {
                
                if (viewModel.isLoading) {
                    DailyOutfitView(index: Int($0))
                        .redacted(reason: .placeholder) 
                } else {
                    DailyOutfitView(index: Int($0))
                }
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .onAppear{
            viewModel.getDressCodeFromCoordinate(coordinate: coordinate)
        }
        .alert(isPresented: $viewModel.showingOutfitAlert) {
            Alert(title: Text("Service is temporarily down."),
                  message: Text("Please try again later"),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    struct WeeklyOutfitView_Previews: PreviewProvider {
        static var previews: some View {
            WeeklyOutfitView(coordinate:CLLocationCoordinate2D(latitude: 42.655251, longitude: -71.139671))
        }
    }
}
