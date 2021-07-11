//
//  CombineDataModel.swift
//  iCityWeather
//
//  Created by 吕博 on 2021/7/10.
//

import Foundation

/// 用于view显示的modal

struct WeatherShowData: Codable {
    var data: WeatherShowDataData? 
    var cityName: String?
    var id: String?
}

struct WeatherShowDataData: Codable {
    var date: String?
    var data: DataData?
    var cityInfo: CityInfo?
    var time: String?
}

/// 未来14天天气
struct Forecast14: Codable, Identifiable, Hashable {
    var id = UUID()
    
    var date: String = ""
    var type: String = ""
    var high: String = ""
    var low: String = ""
}
