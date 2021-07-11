//
//  DataService.swift
//  iCityWeather
//
//  Created by 吕博 on 2021/7/10.
//

import Foundation
import Combine
import SwiftUI

class DataService: ObservableObject {
    
    @Published var showData: WeatherShowData = WeatherShowData(data: nil)
    
    /// 从按照 城市id 返回的温度数据和按照 经纬度 返回的温度数据
    /// 整合view显示用到的最终数据
    /// ```
    /// data : WeatherData类型(城市id返回数据)
    ///        WeatherLocationData类型(经纬度返回数据)
    /// ```
    func updateShowData2<T>(_ data: T?) {
        print(T.Type.self)
        if T.Type.self == WeatherData.Type.self {
            let weather = data as! WeatherData
            
            self.showData.data = WeatherShowDataData()
            self.showData.data!.date = weather.data?.date
            self.showData.data!.cityInfo = weather.data?.cityInfo
            self.showData.data!.data = weather.data?.data
            self.showData.data!.time = weather.data?.time
        } else {
            let weather = data as! WeatherLocationData
            self.showData.data = WeatherShowDataData()
            self.showData.cityName = weather.data?.cityName
            self.showData.id = weather.data?.id
            self.showData.data!.date = weather.data?.weather?.date
            self.showData.data!.cityInfo = weather.data?.weather?.cityInfo
            self.showData.data!.data = weather.data?.weather?.data
            self.showData.data!.time = weather.data?.weather?.time
        }
   //     print(self.showData)
    }
    /// 获取天气数据 - 温度
    /// ```
    ///
    /// ```
    func getCurrentTempure() -> String {
        guard let data = showData.data?.data?.wendu else { return "" }
        return data
    }
    
    func getCurrentCity() -> String {
        guard let data = showData.data?.cityInfo?.city else { return "" }
        return data
    }
    
    func getCurrentParent() -> String {
        guard let data = showData.data?.cityInfo?.parent else { return "" }
        return data
    }
    
    var updataTime: String {
        guard let data = showData.data?.time else { return "" }
        return data
    }
    
    func getTypeIcon(type: String) -> String {
        switch type {
        case "阴", "多云":
            return "cloudy"
        case "中雨", "雷阵雨", "大暴雨", "小雨", "大雨":
            return "storm"
        case "晴":
            return "sunny"
        case "小雪","中雪","大雪":
            return "snow"
        default:
            return "sunny"
        }
    }
    
    var weatherType: String {
        guard let data = showData.data?.data?.forecast?[0].type else { return ("") }
        return data
    }
    
    var weatherTypeIcon: String {
        guard let data = showData.data?.data?.forecast?[0].type else { return ("") }
        switch data {
        case "阴", "多云":
            return "cloudy"
        case "中雨", "雷阵雨", "大暴雨", "小雨", "大雨":
            return "storm"
        case "晴":
            return "sunny"
        case "小雪","中雪","大雪":
            return "snow"
        default:
            return "sunny"
        }
    }
//    var weatherType: (String, String) {
//        guard let data = showData.data?.data?.forecast?[0].type else { return ("", "") }
//
//        print(getTypeIcon(type: data))
//        return (data, getTypeIcon(type: data))
//    }
    
    /// 今日最低温度
    var weatherTodayHigh: String {
        guard let data = showData.data?.data?.forecast?[0].high else { return "" }
        return data
    }
    
    /// 今日最高温度
    var weatherTodayLow: String {
        guard let data = showData.data?.data?.forecast?[0].low else { return "" }
        return data
    }
    
    /// 今日空气质量
    var weatherTodayAir: String {
        guard let data = showData.data?.data?.forecast?[0].aqi else { return "" }
        return String(data)
    }
    
    /// 今日风量风向
    var weatherTodayWind: String {
        guard let wind = showData.data?.data?.forecast?[0].fl else { return "" }
        guard let direction = showData.data?.data?.forecast?[0].fx else { return "" }
        
        print(wind.rawValue)
        print(direction)
  
        return direction + " " + wind.rawValue
    }
    
    var weather14forecast: [Forecast14]? {
        var w14: [Forecast14] = []
        
        guard let forecast = showData.data?.data?.forecast else { return [] }
        
        for i in 1..<forecast.count {
            let w = Forecast14(
                date: forecast[i].date!,
                type: getTypeIcon(type: forecast[i].type!),
                high: forecast[i].high!,
                low: forecast[i].low!)
            w14.append(w)
        }
        
        return w14
    }
}
