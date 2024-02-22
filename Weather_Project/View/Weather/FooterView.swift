//
//  FooterView.swift
//
/// This view shows that the data is powered by AccuWeather, needed for trademark purposes
///
import SwiftUI

import SwiftUI

struct FooterView: View {
    var body: some View {
        HStack(spacing: 0){
           Spacer()
            Text("POWERED BY")
                .font(.system(size: 12))
                .padding(10)
            
            
            Link(destination: URL(string: "http://www.accuweather.com")!) {
                Image("weather/AccuWeather-Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
            }
            
            Spacer()
        }
        .foregroundColor(.white)
    }
}
struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
