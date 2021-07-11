//
//  Picker.swift
//  iCityWeather
//
//  Created by 吕博 on 2021/7/10.
//

import SwiftUI

struct MultiPicker: View {
 
    @EnvironmentObject var vm: WeatherViewModal
    @Binding var showCityList: Bool
    
    init(show: Binding<Bool>) {
        self._showCityList = show
      //  print(CityListData)
    }
    var body: some View {

        VStack {
            
            NavigationView {
                CityListPicker(show: $showCityList)
                    .environmentObject(vm)
            }
            .edgesIgnoringSafeArea(.all)
            
            Spacer()//.frame(height: 100)//.infinity)
            //.frame(height: 400)
        }
        .colorScheme(.dark)
        .edgesIgnoringSafeArea(.all)
      //  .frame(maxHeight: .infinity)
        .background(Color.clear)
        
    }
}

struct MultiPicker_Previews: PreviewProvider {
    static var previews: some View {
        MultiPicker(show: .constant(false))
            .environmentObject(WeatherViewModal())
        
   //     CityListPicker(show: .constant(false))
    }
}

struct CityListPicker: View {

    @EnvironmentObject var vm: WeatherViewModal
    @Binding var showCityList: Bool
    @State private var selectProvince: Int = 0
    @State private var selectCity: Int = 0
    @State private var selectRegion: Int = 0
    
    init(show: Binding<Bool>) {
        self._showCityList = show
      //  print(CityListData)
    }
    
    var body: some View {
        VStack {
          //  Spacer()
            HStack(spacing: 0.0) {
                // 省
                Picker("Select Province", selection: $selectProvince) {
                    
                    if let province = CityListData[0].data {
                        ForEach(0..<province.count) { i in
                            if let data = province[i].cityName {
                                Text(data).bold()//.tag(i)
                            }
                        }
                        .font(.title)
                    }
                }
                .id(0)
                .pickerStyle(DefaultPickerStyle())
                .frame(width: UIScreen.main.bounds.width/3 - 20 , height: UIScreen.main.bounds.height / 3)
              //  .background(Color.orange)
                .clipped()
                
                // 市
                Picker("Select City", selection: $selectCity) {
                    
                    if let province = CityListData[0].data,
                       let city = province[self.selectProvince],
                       let children = city.children {
                        
                        ForEach(0..<children.count) { i in
                            if let data = children[i].cityName {
                                Text(data).bold()
                            }
                        }
                    }
                }
                .pickerStyle(DefaultPickerStyle())
                .id(selectProvince).frame(width: UIScreen.main.bounds.width/3 - 20 , height: UIScreen.main.bounds.height / 3)
                .clipped()
                
                // 区
                Picker("Select Area", selection: $selectRegion) {

                    if let province = CityListData[0].data,
                       let city = province[self.selectProvince],
                       let children = city.children,
                       let number = children.count,
                       selectCity < number ,
                       let childchild = children[selectCity],
                       let region = childchild.children {
                        ForEach(0..<region.count) { i in
                            if i < region.count {
                                if let data = region[i].cityName {
                                    Text(data).bold()
                                }
                            }
                        }
                    }
                }
                .pickerStyle(DefaultPickerStyle())
                .id(selectCity).frame(width: UIScreen.main.bounds.width/3 - 20 , height: UIScreen.main.bounds.height / 3)
                .clipped()
                
            }
            .frame(height: UIScreen.main.bounds.height / 3)
           // .background(Color.orange)
            .navigationBarItems(
                leading: Button("取消", action: {
                    showCityList = false
                }), trailing: Button("确定", action: {
                    
                    print("province: \(self.selectProvince)")
                    print("city: \(self.selectCity)")
                    print("region: \(self.selectRegion)")
                    
                    /// 获取城市id
                    let id = getSelectCityId(province: self.selectProvince, city: self.selectCity, region: self.selectRegion)
                    vm.fetchWeatherDatabyCity(id: id)
                    showCityList = false
                }))
            
            Spacer()
        }
    }
}

/// 根据三个picker的选择项，获取城市id
func getSelectCityId(province: Int, city: Int, region: Int) -> String {

    print(CityListData[0].data![province].children?[city].children?[region].cityName ?? "?")
    print(CityListData[0].data![province].children?[city].cityName ?? "?")
    print(CityListData[0].data![province].cityName ?? "?")
    
    
    if let rname = CityListData[0].data![province].children?[city].children?[region].cityName,
       rname != "" {
        return (CityListData[0].data![province].children?[city].children?[region].id)!
    }
    if let cname = CityListData[0].data![province].children?[city].cityName,
       cname != "" {
        return (CityListData[0].data![province].children?[city].id)!
    }
    return CityListData[0].data![province].id!
}
