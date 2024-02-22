//
//  TodaysOutfit.swift
//
/// Displays one day's weather condition.
/// Its data comes from AccuWeather API
///
import SwiftUI
import MapKit

struct DailyWeatherView: View {
    @ObservedObject var viewModel = WeatherViewModel.shared
    var index : Int
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack{
                //city name
                Text("\(viewModel.geoPostionResult.localizedName),\(viewModel.geoPostionResult.administrativeArea.id)")
                    .font(.title)
                    .fontWeight(.light)
                    .padding(.top, 5)
                    .foregroundColor(.white)
                
                //greetings based on time
                Text("Good \(Date.now.timeOfDay())")
                    .foregroundColor(.gray)
                
                //date
                Text("\(viewModel.fiveDayReport.dailyForecasts[index].date.getDayWeekDay),\(viewModel.fiveDayReport.dailyForecasts[index].date.month) \(viewModel.fiveDayReport.dailyForecasts[index].date.get(.day))")
                    .foregroundColor(.gray)
                
                //weather icon and phrase
                HStack (spacing: 10){
                    Image("weather/\(viewModel.fiveDayReport.dailyForecasts[index].day.iconPhrase.getWeatherImage)")
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                    Text(String(viewModel.fiveDayReport.dailyForecasts[index].day.iconPhrase))
                        .font(.title)
                        .fontWeight(.light)
                }
                .padding(10)
                .foregroundColor(.white)
                //.border(.green, width:5)
                                
                HStack {
                    //temparature, if it's evening time display min temp, if it's day time display max temp -- this applies to today's weather only
                    //for future dates, always display maximum value
                    Text("\(String(Int(viewModel.fiveDayReport.dailyForecasts[index].temperature.maximum.value)))°")
                        .font(.system(size: 70))
                        .fontWeight(.ultraLight)
                        .padding(.trailing, 30)
                        //.border(.red, width: 5)
                    
                    //feels like temparature
                    VStack(alignment: .leading) {
                        HStack {
                            Text("FEELS LIKE")
                            Spacer()
                            Text("\(String(Int(viewModel.fiveDayReport.dailyForecasts[index].realFeelTemperature.maximum.value)))°")
                        }
                        .padding(.bottom, 1)
                        
                        HStack {
                            Text("WIND SPEED")
                            Spacer()
                            Text("\(String(viewModel.fiveDayReport.dailyForecasts[index].day.wind.speed.value)) mph")
                        }
                        .padding(.bottom, 1)
                        
                        HStack {
                            Text("PRECIPITATION")
                            Spacer()
                            Text("\(String(viewModel.fiveDayReport.dailyForecasts[index].day.precipitationProbability))%")
                        }
                        .padding(.bottom, 1)
                    }
                    .font(.caption)
                    .padding(.trailing, 10)
                    .padding(.leading, 20)
                    //.border(.green, width: 5)
                }
                .foregroundColor(.white)
                .padding([.leading,.trailing],25)
            
                Spacer()

                OtherIndexView(index:index)
                    //.border(.red, width:5)
                
                Spacer()
                
                FooterView()
                    .padding(.bottom, 15)
                
                Spacer()
            }
        }
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherView(index: 1)
    }
}

