//
//  TestView.swift
//  iCityWeather
//
//  Created by 吕博 on 2021/7/10.
//

import SwiftUI

struct TestView: View {
    
    init() {
        print(" testview init ")
    }
    var body: some View {
    
        ZStack {
            
            LottieView(filename: "background")
                .edgesIgnoringSafeArea(.all)
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
