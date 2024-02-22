//
//  DailyOutfitView.swift
//
///This view displays one day's outfit
///The view is composed of 2 portions.  Top portion is a brief summary of weather, the bottom part is the outfit suggestion
///
///Weather icon mages come from this site:https://www.iconfinder.com/iconsets/lovely-weather-icons
///Outfix images come from https://www.ssense.com/
///
import SwiftUI
import MapKit

struct DailyOutfitView: View {
    @ObservedObject var viewModel = WeatherViewModel.shared
    var index : Int
    
    var body: some View {
        ZStack{
            OutfitBackground()
            VStack{
                VStack{
                    //city name
                    Text("\(viewModel.geoPostionResult.localizedName), \(viewModel.geoPostionResult.administrativeArea.id)")
                        .font(.system(size: 20))
                        .padding(.top, 10)
                 
                    
                    //greetings based on time
                    //  Text("Good \(Date.now.timeOfDay())!")
                    Text("\(viewModel.fiveDayReport.dailyForecasts[index].date.month) \(viewModel.fiveDayReport.dailyForecasts[index].date.get(.day))")
                        .font(.system(size: 15))
                    
                    //weather description
                    Text(String(viewModel.fiveDayReport.dailyForecasts[index].day.iconPhrase))
                    .font(.system(size: 25))
                    .bold()
                    //.padding(.top, 5)
                    
                    //temperature
                    HStack{
                        Image("weather/black/\(viewModel.fiveDayReport.dailyForecasts[index].day.iconPhrase.getWeatherImage)")
                        .resizable()
                        .frame(width: 40, height: 40)
                        
                        Text("\(String(viewModel.fiveDayReport.dailyForecasts[index].temperature.maximum.value))° F")
                        .font(.system(size: 36))
                        .bold()
                    }
                    // .padding(.top, 1)
                    
                    //Feels temparature
                    Text("Feels like \(String(viewModel.fiveDayReport.dailyForecasts[index].realFeelTemperature.maximum.value))° F")
                    .font(.system(size: 16))
                    //  .padding(.top, 5)
                    
                    //debug purpose, will be deleted
                 //   Text(String((viewModel.dressCode[.female])?[index].imgs[Int.random(in: 0...2)].dropLast(4) ?? ""))
                }
                .foregroundColor(Color(hex:"#1F3C88"))
                
                //clothing suggestion
                ZStack {
                    VStack {
                        Image(String((viewModel.dressCode[viewModel.selectedGender])?[index].imgs[Int.random(in: 0...2)].dropLast(4) ?? ""))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:UIScreen.main.bounds.size.width-40)
                            .padding(15)
                        
                        Spacer()
                    }
                    VStack{
                        HStack{
                            Spacer()
                            //switch gender
                            Button(action: {
                                viewModel.switchGender()
                            },
                                   label: {
                                Image(viewModel.selectedGenderImage)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(.top, 15)
                                    .padding(.trailing, 35)
                            })
                            
                        }
                        Spacer()
                    }
                }
                .frame(width:UIScreen.main.bounds.size.width-20)
               
                Spacer()
            }
        }
    }
}

struct TodaysOutfitView_Previews: PreviewProvider {
    static var previews: some View {
        DailyOutfitView(index: 2)
    }
}
