//
//  iCityWeatherApp.swift
//  iCityWeather
//
//  Created by 吕博 on 2021/7/9.
//

import SwiftUI

@main
struct iCityWeatherApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var showAD: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if self.showAD == true {
                BannerAd(showAD: self.$showAD, slotID: "887507287", width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
            } else {
                WeatherView()
            }
        }
    }
}
