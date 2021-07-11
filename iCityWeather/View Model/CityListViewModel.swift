//
//  cityListService.swift
//  iWeather
//
//  Created by 吕博 on 2021/7/9.
//


import Foundation
import Combine
import Alamofire
import SwiftUI


class CityListViewModel: ObservableObject {
    
    @Published var data: CityList = CityList(data: nil)
    
    private let CityListURL = "http://47.93.85.6:6377/weather/cityList"
    private var task: Cancellable? = nil
    
    let header: HTTPHeaders = HTTPHeaders([
        HTTPHeader(name: "Content-Type", value: "application/json"),
        HTTPHeader(name: "Tenant-ID", value: "154540")
    ])
    
    /// 请求获取城市列表数据
    /// ```
    /// 数据存储在CityList (@Published)
    /// ```
    func fetchCityList() {
        
        print("=====================")
        print("Fetching City List")
        self.task = AF.request(CityListURL,
                               method: .post ,
                               headers: header)
                .validate(statusCode: 200..<300)
                .publishDecodable(type: CityList.self)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case .finished:
                        ()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }, receiveValue: { [weak self](response) in
                    switch response.result {
                    case .success(let model):
                      //  debugPrint(response)
                        print("citylist model : \(model)")
                        self?.data = model
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
    }
}


