//
//   FiveDayForecast.swift
//
///This is the response object returned from Accuweather API -- 5 Days of Daily Forecasts:
///http://dataservice.accuweather.com/forecasts/v1/daily/5day/{geoCode}
///
///The API returns an array of daily forecasts for the next 5 days for a specific location. Forecast searches require a location key. Please use the Locations API to obtain the location key for your desired location. By default, a truncated version of the hourly forecast data is returned. The full object can be obtained by passing "details=true" into the url string.
///
/// This file was generated from JSON Schema using quicktype: https://quicktype.io/
/// To parse the JSON, add this file to your project and do:
///
///   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)
///
///For FiveDayForecast struct, it provides a sample object using static func sample(), it's a convenient func used for testing and preview.
///
import Foundation

// MARK: - FiveDayForecast
struct FiveDayForecast: Codable {
    let headline: Headline
    let dailyForecasts: [DailyForecast]

    enum CodingKeys: String, CodingKey {
        case headline = "Headline"
        case dailyForecasts = "DailyForecasts"
    }
    
    static func sample() -> FiveDayForecast {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let jsonData = fiveDaysampleResponseJson.data(using: .utf8)!
        let fiveDay:FiveDayForecast = try! decoder.decode(FiveDayForecast.self, from: jsonData)
        return fiveDay
    }
}

// MARK: - DailyForecast
struct DailyForecast: Codable {
    let date: Date
    let epochDate: Int
    let sun: Sun
    let moon: Moon
    let temperature, realFeelTemperature, realFeelTemperatureShade: RealFeelTemperature
    let hoursOfSun: Double
    let degreeDaySummary: DegreeDaySummary
    let airAndPollen: [AirAndPollen]
    let day, night: Day
    let sources: [String]
    let mobileLink, link: String

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case epochDate = "EpochDate"
        case sun = "Sun"
        case moon = "Moon"
        case temperature = "Temperature"
        case realFeelTemperature = "RealFeelTemperature"
        case realFeelTemperatureShade = "RealFeelTemperatureShade"
        case hoursOfSun = "HoursOfSun"
        case degreeDaySummary = "DegreeDaySummary"
        case airAndPollen = "AirAndPollen"
        case day = "Day"
        case night = "Night"
        case sources = "Sources"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}

// MARK: - AirAndPollen
struct AirAndPollen: Codable {
    let name: String
    let value: Int
    let category: String
    let categoryValue: Int
    let type: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case value = "Value"
        case category = "Category"
        case categoryValue = "CategoryValue"
        case type = "Type"
    }
}

// MARK: - Day
struct Day: Codable {
    let icon: Int
    let iconPhrase: String
    let hasPrecipitation: Bool
    let precipitationType, precipitationIntensity: String?
    let shortPhrase, longPhrase: String
    let precipitationProbability, thunderstormProbability, rainProbability, snowProbability: Int
    let iceProbability: Int
    let wind, windGust: Wind
    let totalLiquid, rain, snow, ice: Evapotranspiration
    let hoursOfPrecipitation, hoursOfRain: Double
    let hoursOfSnow, hoursOfIce, cloudCover: Int
    let evapotranspiration, solarIrradiance: Evapotranspiration

    enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case iconPhrase = "IconPhrase"
        case hasPrecipitation = "HasPrecipitation"
        case precipitationType = "PrecipitationType"
        case precipitationIntensity = "PrecipitationIntensity"
        case shortPhrase = "ShortPhrase"
        case longPhrase = "LongPhrase"
        case precipitationProbability = "PrecipitationProbability"
        case thunderstormProbability = "ThunderstormProbability"
        case rainProbability = "RainProbability"
        case snowProbability = "SnowProbability"
        case iceProbability = "IceProbability"
        case wind = "Wind"
        case windGust = "WindGust"
        case totalLiquid = "TotalLiquid"
        case rain = "Rain"
        case snow = "Snow"
        case ice = "Ice"
        case hoursOfPrecipitation = "HoursOfPrecipitation"
        case hoursOfRain = "HoursOfRain"
        case hoursOfSnow = "HoursOfSnow"
        case hoursOfIce = "HoursOfIce"
        case cloudCover = "CloudCover"
        case evapotranspiration = "Evapotranspiration"
        case solarIrradiance = "SolarIrradiance"
    }
}

// MARK: - Evapotranspiration
struct Evapotranspiration: Codable {
    let value: Double
    let unit: Unit
    let unitType: Int
    let phrase: String?

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
        case phrase = "Phrase"
    }
}


enum Unit: String, Codable {
    case f = "F"
    case miH = "mi/h"
    case unitIn = "in"
    case wM = "W/m²"
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Evapotranspiration
    let direction: Direction

    enum CodingKeys: String, CodingKey {
        case speed = "Speed"
        case direction = "Direction"
    }
}

// MARK: - Direction
struct Direction: Codable {
    let degrees: Int
    let localized, english: String

    enum CodingKeys: String, CodingKey {
        case degrees = "Degrees"
        case localized = "Localized"
        case english = "English"
    }
}

// MARK: - DegreeDaySummary
struct DegreeDaySummary: Codable {
    let heating, cooling: Evapotranspiration

    enum CodingKeys: String, CodingKey {
        case heating = "Heating"
        case cooling = "Cooling"
    }
}

// MARK: - Moon
struct Moon: Codable {
    let rise: Date?
    let epochRise: Int?
    let moonSet: Date?
    let epochSet: Int?
    let phase: String?
    let age: Int?

    enum CodingKeys: String, CodingKey {
        case rise = "Rise"
        case epochRise = "EpochRise"
        case moonSet = "Set"
        case epochSet = "EpochSet"
        case phase = "Phase"
        case age = "Age"
    }
}

// MARK: - RealFeelTemperature
struct RealFeelTemperature: Codable {
    let minimum, maximum: Evapotranspiration

    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}

// MARK: - Sun
struct Sun: Codable {
    let rise: Date
    let epochRise: Int?
    let sunSet: Date
    let epochSet: Int?

    enum CodingKeys: String, CodingKey {
        case rise = "Rise"
        case epochRise = "EpochRise"
        case sunSet = "Set"
        case epochSet = "EpochSet"
    }
}

// MARK: - Headline
struct Headline: Codable {
    let effectiveDate: Date
    let effectiveEpochDate, severity: Int
    let text, category: String
    let endDate: Date
    let endEpochDate: Int
    let mobileLink, link: String

    enum CodingKeys: String, CodingKey {
        case effectiveDate = "EffectiveDate"
        case effectiveEpochDate = "EffectiveEpochDate"
        case severity = "Severity"
        case text = "Text"
        case category = "Category"
        case endDate = "EndDate"
        case endEpochDate = "EndEpochDate"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}


let fiveDaysampleResponseJson = """

{"Headline":{"EffectiveDate":"2023-04-05T14:00:00-04:00","EffectiveEpochDate":1680717600,"Severity":4,"Text":"Expect showery weather tomorrow afternoon through Thursday afternoon","Category":"rain","EndDate":"2023-04-06T20:00:00-04:00","EndEpochDate":1680825600,"MobileLink":"http://www.accuweather.com/en/us/concord-nh/03301/daily-weather-forecast/329508?lang=en-us","Link":"http://www.accuweather.com/en/us/concord-nh/03301/daily-weather-forecast/329508?lang=en-us"},"DailyForecasts":[{"Date":"2023-04-04T07:00:00-04:00","EpochDate":1680606000,"Sun":{"Rise":"2023-04-04T06:23:00-04:00","EpochRise":1680603780,"Set":"2023-04-04T19:16:00-04:00","EpochSet":1680650160},"Moon":{"Rise":"2023-04-04T17:50:00-04:00","EpochRise":1680645000,"Set":"2023-04-05T06:18:00-04:00","EpochSet":1680689880,"Phase":"WaxingGibbous","Age":14},"Temperature":{"Minimum":{"Value":38.0,"Unit":"F","UnitType":18},"Maximum":{"Value":52.0,"Unit":"F","UnitType":18}},"RealFeelTemperature":{"Minimum":{"Value":32.0,"Unit":"F","UnitType":18,"Phrase":"Cold"},"Maximum":{"Value":59.0,"Unit":"F","UnitType":18,"Phrase":"Cool"}},"RealFeelTemperatureShade":{"Minimum":{"Value":32.0,"Unit":"F","UnitType":18,"Phrase":"Cold"},"Maximum":{"Value":53.0,"Unit":"F","UnitType":18,"Phrase":"Cool"}},"HoursOfSun":1.2,"DegreeDaySummary":{"Heating":{"Value":20.0,"Unit":"F","UnitType":18},"Cooling":{"Value":0.0,"Unit":"F","UnitType":18}},"AirAndPollen":[{"Name":"AirQuality","Value":41,"Category":"Good","CategoryValue":1,"Type":"Ozone"},{"Name":"Grass","Value":2,"Category":"Low","CategoryValue":1},{"Name":"Mold","Value":3250,"Category":"Low","CategoryValue":1},{"Name":"Ragweed","Value":0,"Category":"Low","CategoryValue":1},{"Name":"Tree","Value":7,"Category":"Low","CategoryValue":1},{"Name":"UVIndex","Value":2,"Category":"Low","CategoryValue":1}],"Day":{"Icon":18,"IconPhrase":"Rain","HasPrecipitation":true,"PrecipitationType":"Rain","PrecipitationIntensity":"Light","ShortPhrase":"Rain and drizzle","LongPhrase":"Rain and drizzle beginning in the late morning","PrecipitationProbability":89,"ThunderstormProbability":18,"RainProbability":89,"SnowProbability":0,"IceProbability":0,"Wind":{"Speed":{"Value":3.5,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":316,"Localized":"NW","English":"NW"}},"WindGust":{"Speed":{"Value":9.2,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":10,"Localized":"N","English":"N"}},"TotalLiquid":{"Value":0.08,"Unit":"in","UnitType":1},"Rain":{"Value":0.08,"Unit":"in","UnitType":1},"Snow":{"Value":0.0,"Unit":"in","UnitType":1},"Ice":{"Value":0.0,"Unit":"in","UnitType":1},"HoursOfPrecipitation":3.5,"HoursOfRain":3.5,"HoursOfSnow":0.0,"HoursOfIce":0.0,"CloudCover":96,"Evapotranspiration":{"Value":0.05,"Unit":"in","UnitType":1},"SolarIrradiance":{"Value":2513.8,"Unit":"W/m²","UnitType":33}},"Night":{"Icon":12,"IconPhrase":"Showers","HasPrecipitation":true,"PrecipitationType":"Rain","PrecipitationIntensity":"Light","ShortPhrase":"Cloudy with a shower in spots","LongPhrase":"Cloudy with a shower in spots","PrecipitationProbability":65,"ThunderstormProbability":13,"RainProbability":65,"SnowProbability":0,"IceProbability":0,"Wind":{"Speed":{"Value":4.6,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":48,"Localized":"NE","English":"NE"}},"WindGust":{"Speed":{"Value":10.4,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":71,"Localized":"ENE","English":"ENE"}},"TotalLiquid":{"Value":0.04,"Unit":"in","UnitType":1},"Rain":{"Value":0.04,"Unit":"in","UnitType":1},"Snow":{"Value":0.0,"Unit":"in","UnitType":1},"Ice":{"Value":0.0,"Unit":"in","UnitType":1},"HoursOfPrecipitation":1.0,"HoursOfRain":1.0,"HoursOfSnow":0.0,"HoursOfIce":0.0,"CloudCover":98,"Evapotranspiration":{"Value":0.0,"Unit":"in","UnitType":1},"SolarIrradiance":{"Value":33.4,"Unit":"W/m²","UnitType":33}},"Sources":["AccuWeather"],"MobileLink":"http://www.accuweather.com/en/us/concord-nh/03301/daily-weather-forecast/329508?day=1&lang=en-us","Link":"http://www.accuweather.com/en/us/concord-nh/03301/daily-weather-forecast/329508?day=1&lang=en-us"},{"Date":"2023-04-05T07:00:00-04:00","EpochDate":1680692400,"Sun":{"Rise":"2023-04-05T06:22:00-04:00","EpochRise":1680690120,"Set":"2023-04-05T19:17:00-04:00","EpochSet":1680736620},"Moon":{"Rise":"2023-04-05T18:55:00-04:00","EpochRise":1680735300,"Set":"2023-04-06T06:37:00-04:00","EpochSet":1680777420,"Phase":"WaxingGibbous","Age":15},"Temperature":{"Minimum":{"Value":34.0,"Unit":"F","UnitType":18},"Maximum":{"Value":41.0,"Unit":"F","UnitType":18}},"RealFeelTemperature":{"Minimum":{"Value":29.0,"Unit":"F","UnitType":18,"Phrase":"Cold"},"Maximum":{"Value":35.0,"Unit":"F","UnitType":18,"Phrase":"Cold"}},"RealFeelTemperatureShade":{"Minimum":{"Value":29.0,"Unit":"F","UnitType":18,"Phrase":"Cold"},"Maximum":{"Value":34.0,"Unit":"F","UnitType":18,"Phrase":"Cold"}},"HoursOfSun":0.9,"DegreeDaySummary":{"Heating":{"Value":27.0,"Unit":"F","UnitType":18},"Cooling":{"Value":0.0,"Unit":"F","UnitType":18}},"AirAndPollen":[{"Name":"AirQuality","Value":25,"Category":"Good","CategoryValue":1,"Type":"Particle Pollution"},{"Name":"Grass","Value":0,"Category":"Low","CategoryValue":1},{"Name":"Mold","Value":4875,"Category":"Low","CategoryValue":1},{"Name":"Ragweed","Value":0,"Category":"Low","CategoryValue":1},{"Name":"Tree","Value":2,"Category":"Low","CategoryValue":1},{"Name":"UVIndex","Value":1,"Category":"Low","CategoryValue":1}],"Day":{"Icon":12,"IconPhrase":"Showers","HasPrecipitation":true,"PrecipitationType":"Rain","PrecipitationIntensity":"Light","ShortPhrase":"Cloudy and cooler; p.m. rain","LongPhrase":"Cloudy and cooler; periods of rain in the afternoon","PrecipitationProbability":70,"ThunderstormProbability":0,"RainProbability":70,"SnowProbability":25,"IceProbability":0,"Wind":{"Speed":{"Value":9.2,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":87,"Localized":"E","English":"E"}},"WindGust":{"Speed":{"Value":11.5,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":80,"Localized":"E","English":"E"}},"TotalLiquid":{"Value":0.09,"Unit":"in","UnitType":1},"Rain":{"Value":0.09,"Unit":"in","UnitType":1},"Snow":{"Value":0.0,"Unit":"in","UnitType":1},"Ice":{"Value":0.0,"Unit":"in","UnitType":1},"HoursOfPrecipitation":1.5,"HoursOfRain":1.5,"HoursOfSnow":0.0,"HoursOfIce":0.0,"CloudCover":99,"Evapotranspiration":{"Value":0.04,"Unit":"in","UnitType":1},"SolarIrradiance":{"Value":2377.8,"Unit":"W/m²","UnitType":33}},"Night":{"Icon":12,"IconPhrase":"Showers","HasPrecipitation":true,"PrecipitationType":"Rain","PrecipitationIntensity":"Light","ShortPhrase":"Cloudy with a shower","LongPhrase":"Cloudy with a shower","PrecipitationProbability":80,"ThunderstormProbability":16,"RainProbability":80,"SnowProbability":15,"IceProbability":0,"Wind":{"Speed":{"Value":3.5,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":55,"Localized":"NE","English":"NE"}},"WindGust":{"Speed":{"Value":6.9,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":95,"Localized":"E","English":"E"}},"TotalLiquid":{"Value":0.06,"Unit":"in","UnitType":1},"Rain":{"Value":0.06,"Unit":"in","UnitType":1},"Snow":{"Value":0.0,"Unit":"in","UnitType":1},"Ice":{"Value":0.0,"Unit":"in","UnitType":1},"HoursOfPrecipitation":1.0,"HoursOfRain":1.0,"HoursOfSnow":0.0,"HoursOfIce":0.0,"CloudCover":99,"Evapotranspiration":{"Value":0.0,"Unit":"in","UnitType":1},"SolarIrradiance":{"Value":36.0,"Unit":"W/m²","UnitType":33}},"Sources":["AccuWeather"],"MobileLink":"http://www.accuweather.com/en/us/concord-nh/03301/daily-weather-forecast/329508?day=2&lang=en-us","Link":"http://www.accuweather.com/en/us/concord-nh/03301/daily-weather-forecast/329508?day=2&lang=en-us"},{"Date":"2023-04-06T07:00:00-04:00","EpochDate":1680778800,"Sun":{"Rise":"2023-04-06T06:20:00-04:00","EpochRise":1680776400,"Set":"2023-04-06T19:18:00-04:00","EpochSet":1680823080},"Moon":{"Rise":"2023-04-06T20:03:00-04:00","EpochRise":1680825780,"Set":"2023-04-07T06:58:00-04:00","EpochSet":1680865080,"Phase":"Full","Age":16},"Temperature":{"Minimum":{"Value":40.0,"Unit":"F","UnitType":18},"Maximum":{"Value":60.0,"Unit":"F","UnitType":18}},"RealFeelTemperature":{"Minimum":{"Value":34.0,"Unit":"F","UnitType":18,"Phrase":"Cold"},"Maximum":{"Value":59.0,"Unit":"F","UnitType":18,"Phrase":"Cool"}},"RealFeelTemperatureShade":{"Minimum":{"Value":34.0,"Unit":"F","UnitType":18,"Phrase":"Cold"},"Maximum":{"Value":58.0,"Unit":"F","UnitType":18,"Phrase":"Cool"}},"HoursOfSun":1.7,"DegreeDaySummary":{"Heating":{"Value":15.0,"Unit":"F","UnitType":18},"Cooling":{"Value":0.0,"Unit":"F","UnitType":18}},"AirAndPollen":[{"Name":"AirQuality","Value":25,"Category":"Good","CategoryValue":1,"Type":"Particle Pollution"},{"Name":"Grass","Value":0,"Category":"Low","CategoryValue":1},{"Name":"Mold","Value":7313,"Category":"Moderate","CategoryValue":2},{"Name":"Ragweed","Value":0,"Category":"Low","CategoryValue":1},{"Name":"Tree","Value":5,"Category":"Low","CategoryValue":1},{"Name":"UVIndex","Value":1,"Category":"Low","CategoryValue":1}],"Day":{"Icon":12,"IconPhrase":"Showers","HasPrecipitation":true,"PrecipitationType":"Rain","PrecipitationIntensity":"Moderate","ShortPhrase":"Warmer with a few showers","LongPhrase":"Mostly cloudy and warmer with a couple of showers","PrecipitationProbability":87,"ThunderstormProbability":25,"RainProbability":87,"SnowProbability":0,"IceProbability":0,"Wind":{"Speed":{"Value":4.6,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":176,"Localized":"S","English":"S"}},"WindGust":{"Speed":{"Value":16.1,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":273,"Localized":"W","English":"W"}},"TotalLiquid":{"Value":0.27,"Unit":"in","UnitType":1},"Rain":{"Value":0.27,"Unit":"in","UnitType":1},"Snow":{"Value":0.0,"Unit":"in","UnitType":1},"Ice":{"Value":0.0,"Unit":"in","UnitType":1},"HoursOfPrecipitation":4.0,"HoursOfRain":4.0,"HoursOfSnow":0.0,"HoursOfIce":0.0,"CloudCover":94,"Evapotranspiration":{"Value":0.05,"Unit":"in","UnitType":1},"SolarIrradiance":{"Value":2696.8,"Unit":"W/m²","UnitType":33}},"Night":{"Icon":38,"IconPhrase":"Mostly cloudy","HasPrecipitation":false,"ShortPhrase":"Partly to mostly cloudy","LongPhrase":"Partly to mostly cloudy","PrecipitationProbability":18,"ThunderstormProbability":1,"RainProbability":18,"SnowProbability":0,"IceProbability":0,"Wind":{"Speed":{"Value":10.4,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":281,"Localized":"W","English":"W"}},"WindGust":{"Speed":{"Value":18.4,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":288,"Localized":"WNW","English":"WNW"}},"TotalLiquid":{"Value":0.0,"Unit":"in","UnitType":1},"Rain":{"Value":0.0,"Unit":"in","UnitType":1},"Snow":{"Value":0.0,"Unit":"in","UnitType":1},"Ice":{"Value":0.0,"Unit":"in","UnitType":1},"HoursOfPrecipitation":0.0,"HoursOfRain":0.0,"HoursOfSnow":0.0,"HoursOfIce":0.0,"CloudCover":70,"Evapotranspiration":{"Value":0.02,"Unit":"in","UnitType":1},"SolarIrradiance":{"Value":42.9,"Unit":"W/m²","UnitType":33}},"Sources":["AccuWeather"],"MobileLink":"http://www.accuweather.com/en/us/concord-nh/03301/daily-weather-forecast/329508?day=3&lang=en-us","Link":"http://www.accuweather.com/en/us/concord-nh/03301/daily-weather-forecast/329508?day=3&lang=en-us"},{"Date":"2023-04-07T07:00:00-04:00","EpochDate":1680865200,"Sun":{"Rise":"2023-04-07T06:18:00-04:00","EpochRise":1680862680,"Set":"2023-04-07T19:19:00-04:00","EpochSet":1680909540},"Moon":{"Rise":"2023-04-07T21:13:00-04:00","EpochRise":1680916380,"Set":"2023-04-08T07:22:00-04:00","EpochSet":1680952920,"Phase":"WaningGibbous","Age":17},"Temperature":{"Minimum":{"Value":28.0,"Unit":"F","UnitType":18},"Maximum":{"Value":51.0,"Unit":"F","UnitType":18}},"RealFeelTemperature":{"Minimum":{"Value":21.0,"Unit":"F","UnitType":18,"Phrase":"Very Cold"},"Maximum":{"Value":45.0,"Unit":"F","UnitType":18,"Phrase":"Chilly"}},"RealFeelTemperatureShade":{"Minimum":{"Value":21.0,"Unit":"F","UnitType":18,"Phrase":"Very Cold"},"Maximum":{"Value":42.0,"Unit":"F","UnitType":18,"Phrase":"Chilly"}},"HoursOfSun":6.0,"DegreeDaySummary":{"Heating":{"Value":25.0,"Unit":"F","UnitType":18},"Cooling":{"Value":0.0,"Unit":"F","UnitType":18}},"AirAndPollen":[{"Name":"AirQuality","Value":25,"Category":"Good","CategoryValue":1,"Type":"Particle Pollution"},{"Name":"Grass","Value":0,"Category":"Low","CategoryValue":1},{"Name":"Mold","Value":6582,"Category":"Moderate","CategoryValue":2},{"Name":"Ragweed","Value":0,"Category":"Low","CategoryValue":1},{"Name":"Tree","Value":8,"Category":"Low","CategoryValue":1},{"Name":"UVIndex","Value":5,"Category":"Moderate","CategoryValue":2}],"Day":{"Icon":4,"IconPhrase":"Intermittent clouds","HasPrecipitation":false,"ShortPhrase":"Some sun; windy, cooler","LongPhrase":"Windy and cooler with clouds and sunshine","PrecipitationProbability":11,"ThunderstormProbability":0,"RainProbability":11,"SnowProbability":0,"IceProbability":0,"Wind":{"Speed":{"Value":16.1,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":288,"Localized":"WNW","English":"WNW"}},"WindGust":{"Speed":{"Value":38.0,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":287,"Localized":"WNW","English":"WNW"}},"TotalLiquid":{"Value":0.0,"Unit":"in","UnitType":1},"Rain":{"Value":0.0,"Unit":"in","UnitType":1},"Snow":{"Value":0.0,"Unit":"in","UnitType":1},"Ice":{"Value":0.0,"Unit":"in","UnitType":1},"HoursOfPrecipitation":0.0,"HoursOfRain":0.0,"HoursOfSnow":0.0,"HoursOfIce":0.0,"CloudCover":60,"Evapotranspiration":{"Value":0.1,"Unit":"in","UnitType":1},"SolarIrradiance":{"Value":4519.5,"Unit":"W/m²","UnitType":33}},"Night":{"Icon":34,"IconPhrase":"Mostly clear","HasPrecipitation":false,"ShortPhrase":"Mainly clear and colder","LongPhrase":"Mainly clear and colder","PrecipitationProbability":8,"ThunderstormProbability":0,"RainProbability":4,"SnowProbability":4,"IceProbability":4,"Wind":{"Speed":{"Value":8.1,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":303,"Localized":"WNW","English":"WNW"}},"WindGust":{"Speed":{"Value":25.3,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":301,"Localized":"WNW","English":"WNW"}},"TotalLiquid":{"Value":0.0,"Unit":"in","UnitType":1},"Rain":{"Value":0.0,"Unit":"in","UnitType":1},"Snow":{"Value":0.0,"Unit":"in","UnitType":1},"Ice":{"Value":0.0,"Unit":"in","UnitType":1},"HoursOfPrecipitation":0.0,"HoursOfRain":0.0,"HoursOfSnow":0.0,"HoursOfIce":0.0,"CloudCover":19,"Evapotranspiration":{"Value":0.02,"Unit":"in","UnitType":1},"SolarIrradiance":{"Value":112.7,"Unit":"W/m²","UnitType":33}},"Sources":["AccuWeather"],"MobileLink":"http://www.accuweather.com/en/us/concord-nh/03301/daily-weather-forecast/329508?day=4&lang=en-us","Link":"http://www.accuweather.com/en/us/concord-nh/03301/daily-weather-forecast/329508?day=4&lang=en-us"},{"Date":"2023-04-08T07:00:00-04:00","EpochDate":1680951600,"Sun":{"Rise":"2023-04-08T06:16:00-04:00","EpochRise":1680948960,"Set":"2023-04-08T19:21:00-04:00","EpochSet":1680996060},"Moon":{"Rise":"2023-04-08T22:26:00-04:00","EpochRise":1681007160,"Set":"2023-04-09T07:52:00-04:00","EpochSet":1681041120,"Phase":"WaningGibbous","Age":18},"Temperature":{"Minimum":{"Value":26.0,"Unit":"F","UnitType":18},"Maximum":{"Value":49.0,"Unit":"F","UnitType":18}},"RealFeelTemperature":{"Minimum":{"Value":25.0,"Unit":"F","UnitType":18,"Phrase":"Cold"},"Maximum":{"Value":46.0,"Unit":"F","UnitType":18,"Phrase":"Chilly"}},"RealFeelTemperatureShade":{"Minimum":{"Value":25.0,"Unit":"F","UnitType":18,"Phrase":"Cold"},"Maximum":{"Value":41.0,"Unit":"F","UnitType":18,"Phrase":"Chilly"}},"HoursOfSun":12.7,"DegreeDaySummary":{"Heating":{"Value":28.0,"Unit":"F","UnitType":18},"Cooling":{"Value":0.0,"Unit":"F","UnitType":18}},"AirAndPollen":[{"Name":"AirQuality","Value":41,"Category":"Good","CategoryValue":1,"Type":"Ozone"},{"Name":"Grass","Value":0,"Category":"Low","CategoryValue":1},{"Name":"Mold","Value":5924,"Category":"Low","CategoryValue":1},{"Name":"Ragweed","Value":0,"Category":"Low","CategoryValue":1},{"Name":"Tree","Value":18,"Category":"Moderate","CategoryValue":2},{"Name":"UVIndex","Value":6,"Category":"High","CategoryValue":3}],"Day":{"Icon":1,"IconPhrase":"Sunny","HasPrecipitation":false,"ShortPhrase":"Sunshine","LongPhrase":"Sunshine","PrecipitationProbability":8,"ThunderstormProbability":0,"RainProbability":7,"SnowProbability":1,"IceProbability":0,"Wind":{"Speed":{"Value":11.5,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":304,"Localized":"NW","English":"NW"}},"WindGust":{"Speed":{"Value":25.3,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":304,"Localized":"NW","English":"NW"}},"TotalLiquid":{"Value":0.0,"Unit":"in","UnitType":1},"Rain":{"Value":0.0,"Unit":"in","UnitType":1},"Snow":{"Value":0.0,"Unit":"in","UnitType":1},"Ice":{"Value":0.0,"Unit":"in","UnitType":1},"HoursOfPrecipitation":0.0,"HoursOfRain":0.0,"HoursOfSnow":0.0,"HoursOfIce":0.0,"CloudCover":3,"Evapotranspiration":{"Value":0.11,"Unit":"in","UnitType":1},"SolarIrradiance":{"Value":7608.7,"Unit":"W/m²","UnitType":33}},"Night":{"Icon":33,"IconPhrase":"Clear","HasPrecipitation":false,"ShortPhrase":"Clear","LongPhrase":"Clear","PrecipitationProbability":3,"ThunderstormProbability":0,"RainProbability":1,"SnowProbability":1,"IceProbability":1,"Wind":{"Speed":{"Value":4.6,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":291,"Localized":"WNW","English":"WNW"}},"WindGust":{"Speed":{"Value":11.5,"Unit":"mi/h","UnitType":9},"Direction":{"Degrees":298,"Localized":"WNW","English":"WNW"}},"TotalLiquid":{"Value":0.0,"Unit":"in","UnitType":1},"Rain":{"Value":0.0,"Unit":"in","UnitType":1},"Snow":{"Value":0.0,"Unit":"in","UnitType":1},"Ice":{"Value":0.0,"Unit":"in","UnitType":1},"HoursOfPrecipitation":0.0,"HoursOfRain":0.0,"HoursOfSnow":0.0,"HoursOfIce":0.0,"CloudCover":0,"Evapotranspiration":{"Value":0.01,"Unit":"in","UnitType":1},"SolarIrradiance":{"Value":137.0,"Unit":"W/m²","UnitType":33}},"Sources":["AccuWeather"],"MobileLink":"http://www.accuweather.com/en/us/concord-nh/03301/daily-weather-forecast/329508?day=5&lang=en-us","Link":"http://www.accuweather.com/en/us/concord-nh/03301/daily-weather-forecast/329508?day=5&lang=en-us"}]}
"""

