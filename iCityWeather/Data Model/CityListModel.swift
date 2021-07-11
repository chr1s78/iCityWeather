//
//  Model.swift
//  iWeather
//
//  Created by 吕博 on 2021/7/9.
//

import Foundation

/// CityList JSON Data Model

struct CityListIdentify: Codable, Hashable, Identifiable {
    var id = UUID()
    var data: [Datum]?
}

// MARK: - CityList
struct CityList: Codable, Hashable {
    let data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable, Hashable ,Identifiable {
    let id, cityName: String?
    let children: [Datum]?
    let pid: String?
}

struct paramLocation: Encodable {
    var lng: String = "0"
    var lat: String = "0"
}

//var data1: [Datum] = [
//    Datum(id: "11", cityName: "海淀", children: nil, pid: nil),
//    Datum(id: "12", cityName: "昌平", children: nil, pid: nil),
//    Datum(id: "13", cityName: "朝阳", children: nil, pid: nil),
//    Datum(id: "14", cityName: "丰台", children: nil, pid: nil)
//]
//
//var data3: [Datum] = [
//    Datum(id: "25", cityName: "南岗区", children: nil, pid: nil),
//    Datum(id: "26", cityName: "香坊区", children: nil, pid: nil),
//    Datum(id: "27", cityName: "道外区", children: nil, pid: nil)
//]
//
//var data2: [Datum]
//
//
//var cityData: CityList
//
//init() {
//
//    data2 = [
//        Datum(id: "15", cityName: "哈尔滨", children: data3, pid: nil),
//        Datum(id: "16", cityName: "大庆", children: nil, pid: nil),
//        Datum(id: "17", cityName: "齐齐哈尔", children: nil, pid: nil)
//    ]
//
//    cityData = CityList(data: [
//        Datum(id: "1", cityName: "北京", children: data1, pid: nil),
//        Datum(id: "2", cityName: "黑龙江", children: data2, pid: nil),
//        Datum(id: "3", cityName: "浙江", children: data1, pid: nil),
//        Datum(id: "3", cityName: "浙江", children: data1, pid: nil),
//        Datum(id: "3", cityName: "浙江", children: data1, pid: nil),
//        Datum(id: "3", cityName: "浙江", children: data1, pid: nil),
//        Datum(id: "3", cityName: "浙江", children: data1, pid: nil),
//        Datum(id: "3", cityName: "浙江", children: data1, pid: nil),
//        Datum(id: "3", cityName: "浙江", children: data1, pid: nil),
//        Datum(id: "3", cityName: "浙江", children: data1, pid: nil),
//
//    ])
//}
