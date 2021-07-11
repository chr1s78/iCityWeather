//
//  WeatherLocationDataModel.swift
//  iCityWeather
//
//  Created by 吕博 on 2021/7/10.
//

import Foundation

// MARK: - 根据经纬度获取天气
struct WeatherLocationData: Codable {
    let data: WeatherLocationDataData?
}

// MARK: - WeatherLocationDataData
struct WeatherLocationDataData: Codable {
    let cityName: String?
    let weather: Weather?
    let id: String?
}

struct Weather: Codable {
    let date: String?
    let data: DataData?
    let cityInfo: CityInfo?
    let time: String?
}
