//
// PostalCode.swift
//
///This is the response object returned from Accuweather API -- Post code search:  https://developer.accuweather.com/accuweather-locations-api/apis/get/locations/v1/postalcodes/search
///
///The API returns information for an array of Postal Codes that match the search text.
///
/// This file was generated from JSON Schema using quicktype at https://quicktype.io/
/// To parse the JSON, add this file to your project and do:
///
///   let fiveDayForecast = try? JSONDecoder().decode(FiveDayForecast.self, from: jsonData)
///
///For ZipCodeElement struct, it provides a sample object using static func sample(), it's a convenient func used for testing and preview.
///
import Foundation

// MARK: - WelcomeElement
struct ZipCodeElement: Codable {
    let version: Int
    let key, type: String
    let rank: Int
    let localizedName, englishName, primaryPostalCode: String
    let region, country: Country
    let administrativeArea: AdministrativeArea
    let timeZone: TimeZone
    let geoPosition: GeoPosition
    let isAlias: Bool
    let parentCity: ParentCity?
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
        case parentCity = "ParentCity"
        case supplementalAdminAreas = "SupplementalAdminAreas"
        case dataSets = "DataSets"
    }
    
    static func sample() -> ZipCodeElement {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let jsonData = postalCodesampleResponseJson.data(using: .utf8)!
        let zipCodeElement:[ZipCodeElement] = try! decoder.decode([ZipCodeElement].self, from: jsonData)
        return zipCodeElement[0]
    }
}

// MARK: - AdministrativeArea
struct AdministrativeArea: Codable {
    let id, localizedName, englishName: String
    let level: Int
    let localizedType, englishType, countryID: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
        case level = "Level"
        case localizedType = "LocalizedType"
        case englishType = "EnglishType"
        case countryID = "CountryID"
    }
}

// MARK: - Country
struct Country: Codable {
    let id, localizedName, englishName: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}

// MARK: - GeoPosition
struct GeoPosition: Codable {
    let latitude, longitude: Double
    let elevation: Elevation

    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case elevation = "Elevation"
    }
}

// MARK: - Elevation
struct Elevation: Codable {
    let metric, imperial: Imperial

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}

// MARK: - Imperial
struct Imperial: Codable {
    let value: Int
    let unit: String
    let unitType: Int

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}

// MARK: - ParentCity
struct ParentCity: Codable {
    let key, localizedName, englishName: String

    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}

// MARK: - SupplementalAdminArea
struct SupplementalAdminArea: Codable {
    let level: Int
    let localizedName, englishName: String

    enum CodingKeys: String, CodingKey {
        case level = "Level"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}

// MARK: - TimeZone
struct TimeZone: Codable {
    let code, name: String
    let gmtOffset: Int
    let isDaylightSaving: Bool
    let nextOffsetChange: Date?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case name = "Name"
        case gmtOffset = "GmtOffset"
        case isDaylightSaving = "IsDaylightSaving"
        case nextOffsetChange = "NextOffsetChange"
    }
}

typealias ZipCodeResponse = [ZipCodeElement]



let postalCodesampleResponseJson = """
[
  {
    "Version": 1,
    "Key": "606_PC",
    "Type": "PostalCode",
    "Rank": 105,
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
      "Latitude": 42.662,
      "Longitude": -71.145,
      "Elevation": {
        "Metric": {
          "Value": 27,
          "Unit": "m",
          "UnitType": 5
        },
        "Imperial": {
          "Value": 88,
          "Unit": "ft",
          "UnitType": 0
        }
      }
    },
    "IsAlias": false,
    "ParentCity": {
      "Key": "2251351",
      "LocalizedName": "Andover",
      "EnglishName": "Andover"
    },
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
  },
  {
    "Version": 1,
    "Key": "370616_PC",
    "Type": "PostalCode",
    "Rank": 500,
    "LocalizedName": "Luhtajoki",
    "EnglishName": "Luhtajoki",
    "PrimaryPostalCode": "01810",
    "Region": {
      "ID": "EUR",
      "LocalizedName": "Europe",
      "EnglishName": "Europe"
    },
    "Country": {
      "ID": "FI",
      "LocalizedName": "Finland",
      "EnglishName": "Finland"
    },
    "AdministrativeArea": {
      "ID": "18",
      "LocalizedName": "Uusimaa",
      "EnglishName": "Uusimaa",
      "Level": 1,
      "LocalizedType": "Region",
      "EnglishType": "Region",
      "CountryID": "FI"
    },
    "TimeZone": {
      "Code": "EEST",
      "Name": "Europe/Helsinki",
      "GmtOffset": 3,
      "IsDaylightSaving": true,
      "NextOffsetChange": "2023-10-29T01:00:00Z"
    },
    "GeoPosition": {
      "Latitude": 60.397,
      "Longitude": 24.722,
      "Elevation": {
        "Metric": {
          "Value": 59,
          "Unit": "m",
          "UnitType": 5
        },
        "Imperial": {
          "Value": 195,
          "Unit": "ft",
          "UnitType": 0
        }
      }
    },
    "IsAlias": false,
    "SupplementalAdminAreas": [],
    "DataSets": [
      "AirQualityCurrentConditions",
      "AirQualityForecasts",
      "Alerts",
      "DailyPollenForecast",
      "ForecastConfidence",
      "FutureRadar",
      "MinuteCast",
      "Radar"
    ]
  },
  {
    "Version": 1,
    "Key": "259724_PC",
    "Type": "PostalCode",
    "Rank": 500,
    "LocalizedName": "Villa Verdum",
    "EnglishName": "Villa Verdum",
    "PrimaryPostalCode": "01810",
    "Region": {
      "ID": "NAM",
      "LocalizedName": "North America",
      "EnglishName": "North America"
    },
    "Country": {
      "ID": "MX",
      "LocalizedName": "Mexico",
      "EnglishName": "Mexico"
    },
    "AdministrativeArea": {
      "ID": "CMX",
      "LocalizedName": "México City",
      "EnglishName": "México City",
      "Level": 1,
      "LocalizedType": "Federal District",
      "EnglishType": "Federal District",
      "CountryID": "MX"
    },
    "TimeZone": {
      "Code": "CST",
      "Name": "America/Mexico_City",
      "GmtOffset": -6,
      "IsDaylightSaving": false,
      "NextOffsetChange": null
    },
    "GeoPosition": {
      "Latitude": 19.333,
      "Longitude": -99.195,
      "Elevation": {
        "Metric": {
          "Value": 2331,
          "Unit": "m",
          "UnitType": 5
        },
        "Imperial": {
          "Value": 7649,
          "Unit": "ft",
          "UnitType": 0
        }
      }
    },
    "IsAlias": false,
    "SupplementalAdminAreas": [],
    "DataSets": [
      "AirQualityCurrentConditions",
      "AirQualityForecasts",
      "FutureRadar",
      "MinuteCast",
      "Radar"
    ]
  }
]

"""
