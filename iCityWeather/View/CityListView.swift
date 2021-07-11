//
//  CityListView.swift
//  iCityWeather
//
//  Created by 吕博 on 2021/7/9.
//

import SwiftUI

struct CityListView: View {
    @ObservedObject var vm = CityListViewModel()
    
    init() {
        print("CityListView init")
     //   vm.fetchCityList()
  //      print(drinkData)
    }
    
    var body: some View {
        
        if let data = vm.data.data {
            VStack {

                Text("选择城市")
                    //.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding()

                List(0..<data.count) { i in
                    Text((data[i].cityName)!)
                    if let children = data[i].children {
                        List(0..<children.count) { j in
                            Text(children[j].cityName!)
                        }
                    }
                }
            }
        }
        else {
            ProgressView()
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}
