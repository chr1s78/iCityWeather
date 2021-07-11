//
//  WeatherCityDataModel.swift
//  iCityWeather
//
//  Created by 吕博 on 2021/7/10.
//

import Foundation

// MARK: - 根据城市id获取天气
struct WeatherData: Codable {
    let data: WeatherDataData?
}

struct WeatherDataData: Codable {
    let date: String?
    let data: DataData?
    let cityInfo: CityInfo?
    let time: String?
}

// MARK: - CityInfo
struct CityInfo: Codable {
    let parent, city, citykey, updateTime: String?
}

// MARK: - DataData
struct DataData: Codable {
    let shidu: String?
    let yesterday: Yesterday?
    let pm25, pm10: Int?
    let ganmao: String?
    let forecast: [Yesterday]?
    let wendu, quality: String?
}


// MARK: - Yesterday
struct Yesterday: Codable {
    let date, ymd, high, sunrise: String?
    let fx, week, low: String?
    let fl: FL?
    let sunset: String?
    let aqi: Int?
    let type, notice: String?
}

enum FL: String, Codable {
    case the1级 = "1级"
    case the2级 = "2级"
    case the3级 = "3级"
    case the4级 = "4级"
    case the5级 = "5级"
    case the6级 = "6级"
    case the7级 = "7级"
    case the8级 = "8级"
    case the9级 = "9级"
    case the10级 = "10级"
    case other
}

