import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    let channel : String = "com.mytiki.app"
    let zendeskApi = ZendeskApi()
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      zendeskApi.initZendesk()
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let zendeskChannel = FlutterMethodChannel(name: channel, binaryMessenger: controller.binaryMessenger)
      zendeskChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          switch call.method {
              case "getZendeskCategories" : zendeskApi.getZendeskCategories(result)
              case "getZendeskSection" : zendeskApi.getZendeskSections(call, result)
              case "getZendeskArticles" : zendeskApi.getZendeskArticles(call, result)
              case "getZendeskArticle" : zendeskApi.getZendeskArticle(call, result)
              default : result.notImplemented()
          }
      })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
