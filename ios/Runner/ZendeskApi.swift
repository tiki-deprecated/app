//
//  ZendeskApi.swift
//  Runner
//
//  Created by Ricardo on 13/12/21.
//

import Foundation
import SupportSDK
import ZendeskCoreSDK

class ZendeskApi {

    private var helpcenterProvider : ZDKHelpCenterProvider
    
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
    
    func getZendeskCategories(result: FlutterResult){
        getCategories(
                   {categories -> Void in
                       result.success(categories)},
                   {error -> Void in
                       result.error(error.status.toString(), error.reason, error.toString())}
               )
    }
    
    func getZendeskSections(call: MethodCall, result: FlutterResult){
        getSections(
                   {sections -> Void in
                       result.success(sections)},
                   {error -> Void in
                       result.error(error.status.toString(), error.reason, error.toString())}
               )
    }
    
    func getZendeskArticles(call: MethodCall, result: FlutterResult){
        getArticles(
                   {articles -> Void in
                       result.success(articles)},
                   {error -> Void in
                       result.error(error.status.toString(), error.reason, error.toString())}
               )
    }
    
    func getZendeskArticle(call: MethodCall, result: FlutterResult){
        getArticle(
                   {article -> Void in
                       result.success(article)},
                   {error -> Void in
                       result.error(error.status.toString(), error.reason, error.toString())}
               )
    }
    
    private func getCategories(onSuccess: @escaping  (Array<Dictionary<String, String>>) -> Void,
                               onError: @escaping  (Error) -> Void){
        helpcenterProvider.getCategoriesWithCallback({
            categories, error -> Void in
            guard let element = categories as [ZDKHelpCenterCategory] else {
                            onError(error)
                            return
                       }
                       let result = elements.map { category in
                           return [category.id : category.title]
                       }
                       onSuccess(result)
            })
    }
    
    private func getSections( categoryId: String,
                              onSuccess: @escaping  (Array<Dictionary<String, String>>) -> Void,
                              onError: @escaping  (Error) -> Void){
        helpcenterProvider.getSectionsWithCategoryId(categoryId, {sections, error -> Void in
            guard let element = sections as [ZDKHelpCenterSection] else {
                            onError(error)
                            return
                       }
                       let result = elements.map { section in
                           return [section.id : section.title]
                       }
                       onSuccess(result)
            })
    }
    
    private func getArticles( sectionId: String,
                              onSuccess: @escaping  (Array<Dictionary<String, String>>) -> Void,
                              onError: @escaping  (Error) -> Void){
        helpcenterProvider.getArticlesWithSectionId(sectionId, {articles, error -> Void in
            guard let elements = articles as? [ZDKHelpCenterArticle] else {
                            onError(error)
                            return
                       }
                       let result = elements.map { article in
                           return [article.title : article.body]
                       }
                       onSuccess(result)
        })
    }
    
    
    private func getArticle( articleId: String,
                             onSuccess: @escaping  (Dictionary<String, String>) -> Void,
                             onError: @escaping  (Error) -> Void){
        helpcenterProvider.getArticleWithId(articleId, {article, error -> Void in
            guard let element = article as ZDKHelpCenterArticle else {
                            onError(error)
                            return
                       }
                       let result = elements.map { article in
                           return [article.title : article.body]
                       }
                       onSuccess(result)
            })
    }
}
