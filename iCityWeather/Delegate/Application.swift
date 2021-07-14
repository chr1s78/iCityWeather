
import Foundation
import UIKit
import SwiftUI
import BUAdSDK
import AppTrackingTransparency
import AdSupport

class AppDelegate: NSObject, UIApplicationDelegate, BUSplashAdDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        BUAdSDKManager.setAppID ("5191153")
        BUAdSDKManager.setIsPaidApp(false)
        
        return true
    }
    
    func splashAdDidClickSkip(_ splashAd: BUSplashAdView) {
        print("Delegate: splashAdDidClickSkip")
        splashAd.removeFromSuperview()
    }
    
    
    func splashAdDidClose(_ splashAd: BUSplashAdView) {
        print("Delegate: splashAdDidClose")
        splashAd.removeFromSuperview()
    }
    
    func splashAd(_ splashAd: BUSplashAdView, didFailWithError error: Error?) {
        splashAd.removeFromSuperview()
    }
}

