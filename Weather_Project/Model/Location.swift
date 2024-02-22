// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let locationSearch = try? JSONDecoder().decode(LocationSearch.self, from: jsonData)

//
// Location.swift
//
///This is the response object returned from Accuweather API -- Text Search (results narrowed by countryCode):
/// http://dataservice.accuweather.com/locations/v1/{US}/search
///
///The API returns information for an array of locations that match the search text. Results are narrowed by entering a countryCode in the path.
///
/// This file was generated from JSON Schema using quicktype: https://quicktype.io/
/// To parse the JSON, add this file to your project and do:
///
///   let locationSearch = try? JSONDecoder().decode(LocationSearch.self, from: jsonData)
///
/// For LocationSearchElement struct, it provides a sample object using static func sample(), it's a convenient func used for testing and preview.
///
import Foundation
import MapKit

// MARK: - LocationSearchElement
struct LocationSearchElement: Codable {
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
    
    static func sample() -> LocationSearchElement {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let jsonData = locationJson.data(using: .utf8)!
        let locationSearch: [LocationSearchElement] = try! decoder.decode(LocationSearch.self, from: jsonData)
        return locationSearch[0]
    }
}

typealias LocationSearch = [LocationSearchElement]

// Pin Locations
struct Location: Identifiable, Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.coordinate.latitude == rhs.coordinate.latitude &&
        lhs.coordinate.longitude == rhs.coordinate.longitude
    }
    
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

let locationJson = """
[
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
]
"""
