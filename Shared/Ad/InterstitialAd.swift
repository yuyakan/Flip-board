//
//  InterstitialAd.swift
//  Flip board
//
//  Created by 上別縄祐也 on 2023/11/25.
//

import GoogleMobileAds

class Interstitial: NSObject, GADFullScreenContentDelegate, ObservableObject {
    @Published var interstitialAdLoaded: Bool = false
    
    var interstitialAd: GADInterstitialAd?

    override init() {
        super.init()
    }

    // リワード広告の読み込み
    func loadInterstitial() {
        let id = "cca-app-pub-3940256099942544/4411468910" //テスト
        let request = GADRequest()
        request.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        GADInterstitialAd.load(withAdUnitID: id, request: request) { (ad, error) in
            if let _ = error {
                print("😭: 読み込みに失敗しました")
                self.interstitialAdLoaded = false
                return
            }
            print("😍: 読み込みに成功しました")
            self.interstitialAdLoaded = true
            self.interstitialAd = ad
            self.interstitialAd?.fullScreenContentDelegate = self
        }
    }

    // インタースティシャル広告の表示
    func presentInterstitial() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let root = windowScenes?.keyWindow?.rootViewController
        if let ad = interstitialAd {
            ad.present(fromRootViewController: root!)
            self.interstitialAdLoaded = false
        } else {
            print("😭: 広告の準備ができていませんでした")
            self.interstitialAdLoaded = false
            self.loadInterstitial()
        }
    }
    // 失敗通知
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("インタースティシャル広告の表示に失敗しました")
        self.interstitialAdLoaded = false
        self.loadInterstitial()
    }

    // 表示通知
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("インタースティシャル広告を表示しました")
        self.interstitialAdLoaded = false
    }

    // クローズ通知
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("インタースティシャル広告を閉じました")
        self.interstitialAdLoaded = false
    }
}

