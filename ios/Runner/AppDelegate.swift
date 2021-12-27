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
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let zendeskChannel = FlutterMethodChannel(name: channel, binaryMessenger: controller.binaryMessenger)
      zendeskChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          switch call.method {
            case "getZendeskCategories" : self.zendeskApi.getZendeskCategories(result: result)
            case "getZendeskSection" : self.zendeskApi.getZendeskSections(call: call, result: result)
            case "getZendeskArticles" : self.zendeskApi.getZendeskArticles(call: call, result: result)
            case "getZendeskArticle" : self.zendeskApi.getZendeskArticle(call: call, result: result)
            default : result(FlutterError(code: "-1", message: "Not implemented", details: nil))
          }
      })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
