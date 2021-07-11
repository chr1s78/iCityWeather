//
//  WeatherViewModel.swift
//  iCityWeather
//
//  Created by 吕博 on 2021/7/9.
//

import Foundation
import Combine
import Alamofire
import SwiftUI


class WeatherViewModal: ObservableObject {
    
    @Published var dataService = DataService()
    @Published var Citydata: WeatherData = WeatherData(data: nil)
    @Published var LocationDdata: WeatherLocationData = WeatherLocationData(data: nil)

    private let WeatherByCityURL = "http://47.93.85.6:6377/weather/city"
    private let WeatherByLocationURL = "http://47.93.85.6:6377/weather/location"
    private var WeatherByCitytask: Cancellable? = nil
    private var WeatherByLocationtask: Cancellable? = nil
    
    let header: HTTPHeaders = HTTPHeaders([
        HTTPHeader(name: "Content-Type", value: "application/json"),
        HTTPHeader(name: "Tenant-ID", value: "154540")
    ])
    
    init() {

    }
    
    /// 根据城市id请求某城市天气数据
    /// ```
    /// 数据存储在WeatherData (@Published)
    /// ```
    func fetchWeatherDatabyCity(id: String) {
        
        let parameter = ["id" : id ]
        self.WeatherByCitytask = AF.request(WeatherByCityURL,
                               method: .post ,
                               parameters: parameter,
                               encoder: JSONParameterEncoder.prettyPrinted,
                               headers: header)
                            //   requestModifier: { $0.timeoutInterval = 50 })
              //  .validate(statusCode: 200..<600)
                .publishDecodable(type: WeatherData.self)
            .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case .finished:
                        print("Weather Data receive finished!")
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }, receiveValue: { [weak self](response) in
                    switch response.result {
                    case .success(let model):
                    //    debugPrint(response)
                    //    print("model : \(model)")
                        self?.Citydata = model
                        self?.dataService.updateShowData2(self?.Citydata)
                    case .failure(let error):
                        print(error.localizedDescription)
                        print(String(describing: error))
                    }
                })
    }
    
    /// 根据经纬度请求温度数据
    /// ```
    /// 数据存储在WeatherData (@Published)
    /// ```
    func fetchWeatherbyLocation(lng: String, lat: String) {

        let parameter = paramLocation(lng: lng, lat: lat)
        print("lng = \(lng), lat = \(lat)")
        
        self.WeatherByLocationtask = AF.request(WeatherByLocationURL,
                               method: .post ,
                               parameters: parameter,
                               encoder: JSONParameterEncoder.prettyPrinted,
                               headers: header)
                            //   requestModifier: { $0.timeoutInterval = 50 })
                .validate(statusCode: 200..<300)
                .publishDecodable(type: WeatherLocationData.self)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case .finished:
                        print("Weather Data receive finished!")
                    case .failure(let error):
                        print(error.localizedDescription)
                        print(String(describing: error))
                    }
                }, receiveValue: { [weak self](response) in
                    switch response.result {
                    case .success(let model):
                     //   debugPrint(response)
                     //   print("model : \(model)")
                        self?.LocationDdata = model
                        self?.dataService.updateShowData2(self?.LocationDdata)
                    case .failure(let error):
                        print(error.localizedDescription)
                        print(String(describing: error))
                    }
                })
    }
    
 
}


