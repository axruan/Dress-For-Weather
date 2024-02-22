//
// DressCodeManager.swift
//
///
/// DressCodeManager class consults to pre-fixed DressForWeatherRules to give outfit suggestion based on weather conditions.
///
/// DressForWeatherRules is in json format, the rule is based on temparature and  conditions ( e.g. wind, snow, rain). It also differentiates male and female outfit suggestions.
///
import Foundation

struct DressForWeatherRules {
    let rules: DressForWeather
    
    static let shared = DressForWeatherRules()
     
    private init() {
        let decoder = JSONDecoder()
        let jsonData = dressForWeatherJson.data(using: .utf8)!
        rules = try! decoder.decode(DressForWeather.self, from: jsonData)
    }
}

enum WeatherCondition: String {
    case clearNight = "clear-night"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case fog = "fog"
    case clearDay = "clear-day"
    case sleet = "sleet"
    case snow = "snow"
    case cloudy = "cloudy"
    case wind = "wind"
    case rain = "rain"
}

enum Gender: String {
    case female = "female"
    case male = "male"
}


class DressCodeManager {
    static let shared = DressCodeManager()

    private init() {
    }
    
    private let rules = DressForWeatherRules.shared.rules
    
    ///public function used by view model to get outfit suggestion based on forecast
    ///In parameter `forecast`: DailyForecast, this is the type used by Accuweather APIs
    ///Return  a dictionary of [Gender:Outfit] that contains male and female outfits
    func getDressCodeForWeather(forecast: DailyForecast) -> [Gender:Outfit] {
        let condition = matchWeatherToDresscode(forecast: forecast)
        
        var result = [Gender:Outfit]()
        result[.male] = getTempRange(forecast: forecast, dressCode: rules[condition.rawValue]!.male)
        result[.female] = getTempRange(forecast: forecast, dressCode: rules[condition.rawValue]!.female)
        
        return result
    }
    

    ///translate temparature to a set of ranges
    private func getTempRange(forecast: DailyForecast, dressCode: DressGender) -> Outfit {
    
        let temp = Int(forecast.temperature.maximum.value)
        let result: Outfit
        
        switch Int(convertFtoC(fahrenheit:temp)) {
        case ..<0 :
            result = dressCode.temp.below0
        case 0..<20 :
            result = dressCode.temp.the020
        case 20..<40 :
            result = dressCode.temp.the2040
        case 40... :
            result = dressCode.temp.above40
        default:
            result = dressCode.temp.the020
        }
        
        return result
    }
    
    ///translate weather condition to the condition understandable by dress rules
    private func matchWeatherToDresscode(forecast: DailyForecast) -> WeatherCondition{
                
        switch forecast.day.iconPhrase.getWeatherImage {
        case "sunny" :
            return .clearDay
        case "cloudy" :
            return .cloudy
        case "sleet" :
            return .sleet
        case "rain" :
            return .rain
        case "fog" :
            return .fog
        case "snow":
            return .snow
        case "wind":
            return .wind
        default:
            return .cloudy
        }
    }

    func convertFtoC (fahrenheit: Int) -> Int {
        return (fahrenheit-32) * 5 / 9
        
    }
}
