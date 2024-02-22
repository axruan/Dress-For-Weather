//
//  Extension.swift
//
/// Contains various extensions for convenient functions
///
import Foundation
import SwiftUI
import UIKit

//MARK: NetworkError
extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}

//MARK: Data
extension Data {
    func printJSON() {
        if let JSONString = String(data: self, encoding: .utf8) {
            print(JSONString)
        }
    }
}

//MARK: Date
extension Date {
    func get(_ type: Calendar.Component)-> String {
        let calendar = Calendar.current
        let t = calendar.component(type, from: self)
        return (t < 10 ? "0\(t)" : t.description)
    }
    
    func timeOfDay() -> String {
        let hour = Int(self.get(.hour) )
        
        switch hour! {
        case 7...12 : return "Morning"
        case 13...18: return "Afternoon"
        case 0...6, 18...24: return "Evening"
        default:
            return "Morning"
        }
    }
    
    var isEvening : Bool {
        return self.timeOfDay() == "Evening" ? true : false
    }
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
    
    var timeToString: String {
        let formatter = DateFormatter()
        let format: String = "HH:mm"
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    var getDayWeekDay: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self)
    }
}

//MARK: UIColor
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

//MARK: Color
///Use Hex value for Color
///code comes from this post: https://stackoverflow.com/questions/56874133/use-hex-color-in-swiftui
extension Color {
    init(hex string: String) {
        var string: String = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.hasPrefix("#") {
            _ = string.removeFirst()
        }

        // Double the last value if incomplete hex
        if !string.count.isMultiple(of: 2), let last = string.last {
            string.append(last)
        }

        // Fix invalid values
        if string.count > 8 {
            string = String(string.prefix(8))
        }

        // Scanner creation
        let scanner = Scanner(string: string)

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        if string.count == 2 {
            let mask = 0xFF

            let g = Int(color) & mask

            let gray = Double(g) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)

        } else if string.count == 4 {
            let mask = 0x00FF

            let g = Int(color >> 8) & mask
            let a = Int(color) & mask

            let gray = Double(g) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)

        } else if string.count == 6 {
            let mask = 0x0000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)

        } else if string.count == 8 {
            let mask = 0x000000FF
            let r = Int(color >> 24) & mask
            let g = Int(color >> 16) & mask
            let b = Int(color >> 8) & mask
            let a = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)

        } else {
            self.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
        }
    }
}

//MARK: String
extension String {
    ///convert weather icon phrase to pre-defined condition category
    ///possible return categories are sunnny, cloudy, sleet, rain, fog, snow, wind
    var getWeatherImage: String {
            if self.lowercased().contains("sun") || self.lowercased().contains("clear") {
                return "sunny"
            } else if self.lowercased().contains("cloud") {
                return "cloudy"
            } else if self.lowercased().contains("sleet") {
                return "sleet"
            } else if self.lowercased().contains("rain") ||
                      self.lowercased().contains("showers") ||
                      self.lowercased().matches("t*storms") ||
                        self.lowercased().contains("Juneau"){
                return "rain"
            } else if self.lowercased().contains("fog")  {
                return "fog"
            } else if self.lowercased().contains("snow") ||
                        self.lowercased().contains("flurries") {
                return "snow"
            } else if self.lowercased().contains("wind")  {
                return "wind"
            }
            return "cloudy"
    }
    
    ///encoding string for URL encoding
    var urlEncoded: String? {
        let allowedCharacterSet = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "~-_."))
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
    }
    
    ///Test if a string represents a number
    var isNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
    
    ///test if the string matches a regular expression
    ///In Parameter: `regex` -- regular expression to test against
    ///Return : true if the string matches regex, false if no match
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
