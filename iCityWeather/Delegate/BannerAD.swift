import SwiftUI
import BUAdSDK
import AppTrackingTransparency
import AdSupport

final class BannerAdViewController: NSObject, UIViewControllerRepresentable,  BUNativeExpressBannerViewDelegate, BUSplashAdDelegate {

    @Binding var showAD: Bool
    var slotID: String
    var width: CGFloat
    var height: CGFloat

    init(showAD: Binding<Bool>,slotID: String, width: CGFloat, height: CGFloat) {
        self.slotID = slotID
        self.width = width
        self.height = height
        self._showAD = showAD
    }

    func makeUIViewController(context: Context) -> UIViewController {

        
        let slotID = self.slotID
        let viewController = UIViewController()

        let frame = UIScreen.main.bounds
        let bannerView = BUSplashAdView.init (slotID: slotID, frame: frame)
        viewController.view.addSubview(bannerView)
        bannerView.frame = CGRect(x:0, y:0, width: width, height: height)
        bannerView.delegate = self

        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                print("=====status :\(status)")
                DispatchQueue.main.async {
                    bannerView.loadAdData()
                }
            })
        } else {
            bannerView.loadAdData()
        }
        
        let keyWindow = UIApplication.shared.windows.first
        keyWindow?.rootViewController?.view.addSubview(bannerView)
        bannerView.rootViewController = keyWindow?.rootViewController
     
        
        return viewController
    }
    
    func splashAdDidClickSkip(_ splashAd: BUSplashAdView) {
        print("splashAdDidClickSkip")
        splashAd.removeFromSuperview()
    }
    
    
    func splashAdDidClose(_ splashAd: BUSplashAdView) {
        print("splashAdDidClose")
        self.showAD = false
        splashAd.removeFromSuperview()
    }
    
    func splashAd(_ splashAd: BUSplashAdView, didFailWithError error: Error?) {
        print("splashAd")
        splashAd.removeFromSuperview()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct BannerAd: View {

    @Binding var showAD: Bool
    var slotID: String
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        HStack {
            Spacer()
            BannerAdViewController(showAD: $showAD,slotID: slotID, width: width, height: height)
                .frame(width: width, height: height, alignment: .center)
            Spacer()
        }
    }
}

struct BannerAd_Previews: PreviewProvider {
    static var previews: some View {
        BannerAd(showAD: .constant(true), slotID: "887507287", width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}
