//
//  BackgroundView.swift
//
/// The background view of outfit view.  It uses gradient colors.
/// 
import SwiftUI

let colorScheme = [Color(hex: "#A8E6CF"),
                   Color(hex: "#E7E6EF"),
                   Color(hex: "#FFF6E9")]

let gradient = Gradient(colors: colorScheme)
let linearGradient = LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)

struct OutfitBackground: View {
    
    var body: some View {

        ZStack{
            
            Rectangle()
                .fill(linearGradient)
                .blur(radius: 300, opaque: true)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct OutfitBackground_Previews: PreviewProvider {
    static var previews: some View {
        OutfitBackground()
    }
}

