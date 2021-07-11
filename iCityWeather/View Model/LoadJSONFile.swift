//
//  LoadJSONFile.swift
//  iCityWeather
//
//  Created by 吕博 on 2021/7/11.
//

import Foundation
import SwiftUI

let CityListData: [CityList] = load("CityListJSON.json")
//var CityListData2: CityListIdentify? = nil

func load<T:Decodable>(_ filename:String, as type:T.Type = T.self) -> T {
    let data:Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main Bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't find \(filename) from main Bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

//func CopyCityList() {
//    CityListData2.data = CityListData[0].data
//}

class LoadJsonFile: ObservableObject {
    
    @Published var data: CityList = CityList(data: nil)
    
    func FetchCityListJSONFile() {
        let jsonData = readLocalJSONFile(forName: "CityListJSON.json")
  //      print("jsondata ---- \(jsonData)")
        if let data = jsonData {
        if let sampleRecordObj = parse(jsonData: data) {
            print(sampleRecordObj)
            }
        }
    }
    
    func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                print("filePath --- \(filePath)")
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    func parse(jsonData: Data) -> CityList? {
        do {
            let decodedData = try JSONDecoder().decode(CityList.self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        return nil
    }

}

