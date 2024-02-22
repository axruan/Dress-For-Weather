//
// GeoPostion.swift
//

///This is the response object returned from Accuweather API -- Geoposition Search:
/// http://dataservice.accuweather.com/locations/v1/cities/geoposition/search
///
///The API returns information about a specific location, by GeoPosition (Latitude and Longitude).
///
/// This file was generated from JSON Schema using quicktype at https://quicktype.io/
/// To parse the JSON, add this file to your project and do:
///
///   let geoposition = try? JSONDecoder().decode(Geoposition.self, from: jsonData)
///
///For GeopositionResponse struct, it provides a sample object using static func sample(), it's a convenient func used for testing and preview.
///
import Foundation

// MARK: - Geoposition
struct GeopositionResponse: Codable {
    let version: Int
    let key, type: String
    let rank: Int
    let localizedName, englishName, primaryPostalCode: String
    let region, country: Country
    let administrativeArea: AdministrativeArea
    let timeZone: TimeZone
    let geoPosition: GeoPosition
    let isAlias: Bool
    let supplementalAdminAreas: [SupplementalAdminArea]
    let dataSets: [String]

    enum CodingKeys: String, CodingKey {
        case version = "Version"
        case key = "Key"
        case type = "Type"
        case rank = "Rank"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
        case primaryPostalCode = "PrimaryPostalCode"
        case region = "Region"
        case country = "Country"
        case administrativeArea = "AdministrativeArea"
        case timeZone = "TimeZone"
        case geoPosition = "GeoPosition"
        case isAlias = "IsAlias"
        case supplementalAdminAreas = "SupplementalAdminAreas"
        case dataSets = "DataSets"
    }
    
    static func sample() -> GeopositionResponse {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let jsonData = json.data(using: .utf8)!
        let geopositionResponse:GeopositionResponse = try! decoder.decode(GeopositionResponse.self, from: jsonData)
        return geopositionResponse
    }
}


let json = """
{
  "Version": 1,
  "Key": "2251351",
  "Type": "City",
  "Rank": 75,
  "LocalizedName": "Andover",
  "EnglishName": "Andover",
  "PrimaryPostalCode": "01810",
  "Region": {
    "ID": "NAM",
    "LocalizedName": "North America",
    "EnglishName": "North America"
  },
  "Country": {
    "ID": "US",
    "LocalizedName": "United States",
    "EnglishName": "United States"
  },
  "AdministrativeArea": {
    "ID": "MA",
    "LocalizedName": "Massachusetts",
    "EnglishName": "Massachusetts",
    "Level": 1,
    "LocalizedType": "State",
    "EnglishType": "State",
    "CountryID": "US"
  },
  "TimeZone": {
    "Code": "EDT",
    "Name": "America/New_York",
    "GmtOffset": -4,
    "IsDaylightSaving": true,
    "NextOffsetChange": "2023-11-05T06:00:00Z"
  },
  "GeoPosition": {
    "Latitude": 42.658,
    "Longitude": -71.137,
    "Elevation": {
      "Metric": {
        "Value": 50,
        "Unit": "m",
        "UnitType": 5
      },
      "Imperial": {
        "Value": 164,
        "Unit": "ft",
        "UnitType": 0
      }
    }
  },
  "IsAlias": false,
  "SupplementalAdminAreas": [
    {
      "Level": 2,
      "LocalizedName": "Essex",
      "EnglishName": "Essex"
    }
  ],
  "DataSets": [
    "AirQualityCurrentConditions",
    "AirQualityForecasts",
    "Alerts",
    "DailyAirQualityForecast",
    "DailyPollenForecast",
    "ForecastConfidence",
    "FutureRadar",
    "MinuteCast",
    "Radar"
  ]
}
"""
