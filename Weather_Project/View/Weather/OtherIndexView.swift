//
//  OtherIndexView.swift
//
/// This view displays addtional weather indexes
///
import SwiftUI
import MapKit

struct OtherIndexView: View {
    @ObservedObject var viewModel = WeatherViewModel.shared
    var index : Int
    
    var body: some View {
        VStack (spacing: 15){

            //sun
            HStack{
                Text("Sunrise")
                Spacer()
                Text("\(viewModel.fiveDayReport.dailyForecasts[index].sun.rise.timeToString)")
            }
            
            HStack{
                Text("Sunset")
                Spacer()
                Text("\(viewModel.fiveDayReport.dailyForecasts[index].sun.sunSet.timeToString)")
            }
                  
            //hours of sun
            HStack{
                Text("Hours of Sun")
                Spacer()
                Text("\(String(viewModel.fiveDayReport.dailyForecasts[index].hoursOfSun))")
            }
            
            //air quality
            HStack{
                Text("Air quality ")
                Spacer()
                Text("\(String(viewModel.fiveDayReport.dailyForecasts[index].airAndPollen.filter({$0.name == "AirQuality"})[0].category))")
            }
            
            //uv index
            HStack{
                Text("UV Index")
                Spacer()
                Text("\(String(viewModel.fiveDayReport.dailyForecasts[index].airAndPollen.filter({$0.name == "UVIndex"})[0].value))")
            }
            
            //cloud cover
            HStack{
                Text("Cloud Cover")
                Spacer()
                Text("\(viewModel.fiveDayReport.dailyForecasts[index].day.cloudCover)%")
            }
        }
        .foregroundColor(.white)
        .padding(.leading, 30)
        .padding(.trailing, 30)
    }
}

struct OtherIndexView_Previews: PreviewProvider {
    static var previews: some View {
        OtherIndexView(index: 2)
    }
}


