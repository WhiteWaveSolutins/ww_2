import UIKit
import UserNotifications
import Flutter
import ApphudSDK
import AdServices

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        Apphud.start(apiKey: "app_hYgADaGkQFSg4wp4AS7z4Yqi9t7AzG")
        trackAppleSearchAds()
        registerForNotifications()
        
        GeneratedPluginRegistrant.register(with: self)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func registerForNotifications(){
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            // handle if needed
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Apphud.submitPushNotificationsToken(token: deviceToken) { isSubmitted in
            print("Submitted Push Token Status: \(isSubmitted ? "Success" : "Failed")")
        }
    }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if Apphud.handlePushNotification(apsInfo: response.notification.request.content.userInfo) {
            // Push Notification was handled by Apphud, probably do nothing
        } else {
            // Handle other types of push notifications
        }
        completionHandler()
    }
    
    func trackAppleSearchAds() {
            if #available(iOS 14.3, *) {
                Task {
                    if let asaToken = try? AAAttribution.attributionToken() {
                        Apphud.addAttribution(data: nil, from: .appleAdsAttribution, identifer: asaToken, callback: nil)
                    }
                }
            }
        }
}