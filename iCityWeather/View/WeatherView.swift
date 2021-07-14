//
//  WeatherView.swift
//  iCityWeather
//
//  Created by 吕博 on 2021/7/9.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var vm: WeatherViewModal
    @ObservedObject var lm: LocationManager
    @State var showCityList: Bool = false
    
    /// Location details
    var latitude: Double {
        get {
            return lm.location?.latitude ?? 0
        }
    }
    var longitude: Double  { return lm.location?.longitude ?? 0 }
    var zip: String { return lm.placemark?.postalCode ?? "2100" }
    var country_code: String { return lm.placemark?.isoCountryCode ?? "PH" }
    var status: String    { return("\(String(describing: lm.status))") }
    
    init() {
        vm = WeatherViewModal()
        lm = LocationManager()
    }
    
    var body: some View {
        
        ZStack {
            LottieView(filename: "background")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 80) {
                
                WeatherHeaderView(lon: longitude, lat: latitude, show: $showCityList)
                    .environmentObject(vm)
                    .padding([.leading, .trailing])
                
                WeatherBodyView()
                    .environmentObject(vm)
                    .padding([.leading, .trailing])
                
                WeatherBottomView()
                    .environmentObject(vm)
                Spacer()
            }
            
            MultiPicker(show: $showCityList)
                .environmentObject(vm)
                .animation(.spring())
                .edgesIgnoringSafeArea(.all)
                .offset(y: self.showCityList ? 400 : UIScreen.main.bounds.height)
        }
        .tag(/*@START_MENU_TOKEN@*/"Tag"/*@END_MENU_TOKEN@*/)
        .onAppear {
            vm.fetchWeatherbyLocation(lng: String(longitude), lat: String(latitude))
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

struct WeatherHeaderView: View {
    @EnvironmentObject var vm: WeatherViewModal
    @Binding var showCityList: Bool
    
    var longitude: Double
    var latitude: Double
    
    init(lon: Double, lat: Double, show: Binding<Bool>) {
        self.longitude = lon
        self.latitude = lat
        self._showCityList = show
    }

    var body: some View {
        HStack {
            Button(action: {
                print("click left button")
                vm.fetchWeatherbyLocation(lng: String(longitude), lat: String(latitude))
            }, label: {
                Image(systemName: "location.fill")
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
            })
            .offset(x: -20)
            
            Spacer()
            
            VStack(spacing: 10.0) {
                Text(vm.dataService.getCurrentCity() + " " + vm.dataService.getCurrentParent())
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    .padding(.top, 0)
                
                HStack {
                    Text(vm.dataService.updataTime)
                        .font(.footnote)
                        .fontWeight(.light)
                    Text("更新")
                        .font(.footnote)
                        .fontWeight(.light)
                    
                }
                .foregroundColor(.white)
            }
            
            Spacer()
            
            Button(action: {
                print("click right button")
                self.showCityList.toggle()
            }, label: {
                Image(systemName: "repeat.circle.fill")
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
            })
            .offset(x: 20)
            
        }
        .padding()
        .colorScheme(.dark)
    }
}

struct WeatherBodyView: View {
    @EnvironmentObject var vm: WeatherViewModal
    
    var body: some View {
        
        VStack(spacing: 2.0) {
            
            HStack(spacing: 20.0) {
               // Image(vm.dataService.weatherType.1)
                if let data = vm.dataService {
                    
                    switch(data.weatherType) {
                    case "阴", "多云":
                        LottieView(filename: "cloudy")
                            .frame(width: 50, height: 50)
                    case "中雨", "雷阵雨", "大暴雨", "小雨", "大雨":
                        LottieView(filename: "storm")
                            .frame(width: 50, height: 50)
                    case "晴":
                        LottieView(filename: "sunny")
                            .frame(width: 50, height: 50)
                    case "小雪","中雪","大雪":
                        LottieView(filename: "snow")
                            .frame(width: 50, height: 50)
                    default:
                        LottieView(filename: "sunny")
                            .frame(width: 50, height: 50)
                    }
                   
                    Text(data.weatherType)
                        .font(.system(size: 30))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            
            HStack {
                Text(vm.dataService.getCurrentTempure() + "º")
                    .font(.system(size: 150))
                    .fontWeight(.ultraLight)
                    .foregroundColor(.white)

                VStack(alignment: .leading, spacing: 10.0) {
                    Text("最高温度:  " + vm.dataService.weatherTodayHigh + "º")
                    Text("最低温度:  " + vm.dataService.weatherTodayLow + "º")
                    Text("空气质量:  " + vm.dataService.weatherTodayAir)
                    Text("风向风量:  " + vm.dataService.weatherTodayWind)
                }
               // .font(.footnote)
                .font(.system(size: 15))
                .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.leading, 0)
        }
    }
}

struct WeatherBottomView: View {
    @EnvironmentObject var vm: WeatherViewModal
    
    var body: some View {
        VStack {
            HStack {
                Text("未来14日天气预报")
                    .foregroundColor(.gray)
                
                Spacer()
            }.padding(.leading)
        
            Divider()
            
            ScrollView {
                
                ForEach(0..<14) { index in
                    HStack {
                        if let data = vm.dataService.weather14forecast,
                           data.count > 0 {
                            Text(data[index].date + "日")
                            Spacer()
                            
                            LottieView(filename: data[index].type)
                                .frame(width: 32, height: 32)
//                            Image(data[index].type)
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 32, height: 32)
                            Spacer()
                            Text(data[index].high+"º")
                            Text(data[index].low+"º")
                                .fontWeight(.ultraLight)
                        }

                        
                    }
                    .padding([.leading, .trailing])
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                }
            }
        }
  
    }
}

struct WeatherRowView: View {
    
    @EnvironmentObject var vm: WeatherViewModal
    
    var body: some View {
        HStack {
            Text("7月1日")
            Spacer()
            Image("rain")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
            Spacer()
            Text("36"+"º")
            Text("26"+"º")
                .fontWeight(.ultraLight)
        }
        .padding([.leading, .trailing])
        .font(.system(size: 20))
        .foregroundColor(.white)
    }
}
