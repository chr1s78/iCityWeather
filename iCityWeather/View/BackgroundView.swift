//
//  BackgroundView.swift
//  iCityWeather
//
//  Created by 吕博 on 2021/7/11.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        let colorScheme = [Color.black,
                           Color(red: 20/255, green: 31/255, blue: 78/255),
                           Color(red: 141/255, green: 87/255, blue: 151/255)]
        
        let gradient = Gradient(colors: colorScheme)
        let linearGradient = LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
        
        let background = Rectangle()
            .fill(linearGradient)
        .blur(radius: 200, opaque: true)
        .edgesIgnoringSafeArea(.all)
            

          
        
        return background
    }
}
