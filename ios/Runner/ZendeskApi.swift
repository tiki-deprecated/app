
//
//  ZendeskApi.swift
//  Runner
//
//  Created by Ricardo on 13/12/21.
//

import Foundation
import Flutter
import SupportSDK
import ZendeskCoreSDK

class ZendeskApi {

    private var helpcenterProvider : ZDKHelpCenterProvider;
    
    public init() {
        CoreLogger.enabled = true
        CoreLogger.logLevel = .debug
        Zendesk.initialize(
            appId: "12abbc10c46d1731876d529d0b90656cc81d416a9452d0be",
            clientId: "mobile_sdk_client_3beab601d34d787fc05c",
            zendeskUrl: "https://mytikihelp.zendesk.com/"
        )
        let identity = Identity.createAnonymous()
        helpcenterProvider = ZDKHelpCenterProvider()
        Zendesk.instance?.setIdentity(identity)

    }
    
    func getZendeskCategories(result:  @escaping FlutterResult){
        getCategories(
            onSuccess: {categories -> Void in result(categories)},
            onError: {error -> Void in
                result(FlutterError.init(code: "-1", message: error?.localizedDescription ?? "Generic error on line 36 ZendeskApi", details: nil))
            }
       )
    }
    
    func getZendeskSections(call: FlutterMethodCall, result:  @escaping FlutterResult){
        guard let args = call.arguments as? Dictionary<String, Any>,
              let categoryId = args["categoryId"] as? String else{
                  result(FlutterError.init(code:"400", message:"categoryId argument is missing", details: nil))
                  return
        }
        getSections(
            categoryId: categoryId,
            onSuccess: {sections -> Void in result(sections)},
            onError: {error -> Void in
                result(FlutterError.init(code: "-1", message: error?.localizedDescription ?? "Generic error on line 52 ZendeskApi", details: nil))
            }
       )
    }
    
    func getZendeskArticles(call: FlutterMethodCall, result:  @escaping FlutterResult){
        guard let args = call.arguments as? Dictionary<String, Any>,
              let sectionId = args["sectionId"] as? String else{
                  result(FlutterError.init(code:"400", message:"sectionId argument is missing", details: nil))
                  return
        }
        getArticles(
            sectionId: sectionId,
            onSuccess: {articles -> Void in result(articles)},
            onError: {error -> Void in
                result(FlutterError.init(code: "-1", message: error?.localizedDescription ?? "Generic error on line 67 ZendeskApi", details: nil))
            }
       )
    }
    
    func getZendeskArticle(call: FlutterMethodCall, result: @escaping FlutterResult){
        guard let args = call.arguments as? Dictionary<String, Any>,
              let articleId = args["articleId"] as? String else{
                  result(FlutterError.init(code:"400", message: "articleId argument is missing", details: nil))
            return
        }
        getArticle(
            articleId: articleId,
            onSuccess: {article -> Void in result(article)},
            onError: {error -> Void in
                result(FlutterError.init(code: "-1", message: error?.localizedDescription ?? "Generic error on line 82 ZendeskApi", details: nil))
            }
        )
    }
    
    private func getCategories(onSuccess: @escaping  ([String: Any]) -> Void,
                               onError: @escaping  (Error?) -> Void){
        helpcenterProvider.getCategoriesWithCallback({ categories, error -> Void in
            let result = categories.map { element -> [String:Any] in
                let category = element as AnyObject
                guard let cat = category as? ZDKHelpCenterCategory else{
                    onError(error)
                    return [:]
                }
                return [
                    "id" : cat.identifier ?? 0,
                    "title" : cat.name ?? "",
                    "description"  : cat.description
                ]
            }
            onSuccess(result!)
        })
    }
    
    private func getSections( categoryId: String,
                              onSuccess: @escaping  ([String:Any]) -> Void,
                              onError: @escaping  (Error?) -> Void){
        helpcenterProvider.getSectionsWithCategoryId(categoryId,  withCallback: {sections, error -> Void in
            let result = sections.map { element -> [String:Any] in
                let section = element as AnyObject
                guard let sect = section as? ZDKHelpCenterSection else{
                          onError(error)
                          return [:]
                }
                return [
                    "id" : sect.identifier ?? 0,
                    "title" : sect.name ?? "",
                    "description"  : sect.description
                ]
            }
            onSuccess(result!)
        })
    }
    
    private func getArticles( sectionId: String,
                              onSuccess: @escaping  ([String:Any]) -> Void,
                              onError: @escaping  (Error?) -> Void){
        helpcenterProvider.getArticlesWithSectionId(sectionId,  withCallback: {articles, error -> Void in
            let result = articles.map { element -> [String:Any] in
                let article = element as AnyObject
                guard let art = article as? ZDKHelpCenterArticle else{
                          onError(error)
                    return [:]
                }
                let updatedAt = self.getStringFromDate(date: art.created_at)
                return [
                    "id" : art.identifier ?? 0,
                    "title" : art.title ?? "",
                    "content"  : art.body ?? "",
                    "updatedAt" : updatedAt ?? ""
                ]
            }
            onSuccess(result!)
        })
    }
    
    
    private func getArticle( articleId: String,
                             onSuccess: @escaping  ([String:Any]) -> Void,
                             onError: @escaping  (Error?) -> Void){
        helpcenterProvider.getArticleWithId(articleId, withCallback: {article, error -> Void in
            let articleObj = article as AnyObject
            guard let art = articleObj as? ZDKHelpCenterArticle else{
                      onError(error)
                     return
            }
            let updatedAt = self.getStringFromDate(date: art.created_at)
            let result : [String:Any] = [
                "id" : art.identifier ?? 0,
                "title" : art.title ?? "",
                "content"  : art.body ?? "",
                "updatedAt" : updatedAt ?? ""
            ]
            onSuccess(result)
        })
    }
    
    private func getStringFromDate(date: Date) -> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss YYYY"
        return dateFormatter.string(from: date)
    }
}
