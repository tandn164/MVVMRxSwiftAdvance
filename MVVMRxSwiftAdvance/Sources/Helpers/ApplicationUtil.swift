//
//  ApplicationUtil.swift
//  MVVMRxSwift
//
//  Created by Nguyễn Đức Tân on 22/04/2023.
//

import Foundation
import UIKit
import SafariServices

class ApplicationUtil {
    
    static let isDebug: Bool = { () -> Bool in
        #if DEBUG
        return true
        #else
        return false
        #endif
    }()
    
    static var version: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    static let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    
    static var topViewController: UIViewController? {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            var top = keyWindow?.rootViewController
            while (top?.presentedViewController) != nil {
                if let presentVC = top?.presentedViewController {
                    if presentVC.isBeingDismissed {
                        break
                    } else {
                        top = presentVC
                    }
                }
            }
            return top
        } else {
            return UIApplication.shared.topMostViewController()
        }
    }
    
    static var mainView: MainViewController? {
        var mainView: UIViewController?
        
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            if #available(iOS 15.0, *) {
                mainView = scene?.keyWindow?.rootViewController
            } else {
                mainView = scene?.windows.first(where: { $0.isKeyWindow })?.rootViewController
            }
        } else {
            mainView = UIApplication.shared.keyWindow?.rootViewController
        }
        return mainView as? MainViewController
    }

    static func openURL(_ url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    static func openInternalBrowserWithUrl(_ urlString: String) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            let safariVC = SFSafariViewController(url: url)
            
            if #available(iOS 11.0, *) {
                safariVC.dismissButtonStyle = .close
            }
            
            safariVC.preferredBarTintColor = UIColor(red: 4 / 255.0, green: 41 / 255.0, blue: 59 / 255.0, alpha: 1)
            
            ApplicationUtil.topViewController?.presentVC(safariVC)
        }
    }
    
    static var requestCookie: HTTPCookie? {
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies where cookie.name == "GSESSION" {
                return cookie
            }
        }
        return nil
    }
    
    static func clearCookie() {
        HTTPCookieStorage.shared.cookies?.forEach({ cookie in
            HTTPCookieStorage.shared.deleteCookie(cookie)
        })
    }
    
    static func delay(seconds: Double, execute: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
    }

    static func backgroundDelay(seconds: Double, execute: @escaping () -> Void) {
       DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + seconds, execute: execute)
    }

    static func openSafari(urlStr: String) {
        guard let url = URL(string: urlStr) else {
            return
        }
        if (UIApplication.shared.canOpenURL(url)) {
            UIApplication.shared.open(url)
        }
    }

    static func generateCode128Barcode(_ string: String) -> UIImage? {
        guard let data = string.data(using: .utf8) else {
            return nil
        }
        
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
            return nil
        }
        
        filter.setValue(data, forKey: "inputMessage")
        
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        guard let output = filter.outputImage?.transformed(by: transform) else {
            return nil
        }
        
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(output, from: output.extent) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}


