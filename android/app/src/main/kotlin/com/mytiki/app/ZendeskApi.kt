package com.mytiki.app

import android.content.Context
import com.zendesk.service.ErrorResponse
import com.zendesk.service.ZendeskCallback
import zendesk.core.AnonymousIdentity
import zendesk.core.Identity
import zendesk.core.Zendesk
import zendesk.support.*

typealias ListCallback<T> = (T) -> Unit
typealias SingleCallback<T> = (T) -> Unit
typealias ErrorCallback = (ErrorResponse) -> Unit

class ZendeskApi {

    private lateinit var providerStore: ProviderStore
    private lateinit var helpCenterProvider: HelpCenterProvider

    public fun initZendesk(context : Context) {
        val url = "https://mytikihelp.zendesk.com/"
        val appId = "12abbc10c46d1731876d529d0b90656cc81d416a9452d0be"
        val clientId = "mobile_sdk_client_3beab601d34d787fc05c"
        Zendesk.INSTANCE.init(context,
                url,
                appId,
                clientId)
        Support.INSTANCE.init(Zendesk.INSTANCE)
        val identity: Identity = AnonymousIdentity.Builder().build()
        Zendesk.INSTANCE.setIdentity(identity)
        providerStore = Support.INSTANCE.provider()!!
        helpCenterProvider = providerStore.helpCenterProvider()
    }

    public fun getCategories(onSuccess: ListCallback<List<Category>>, onError: ErrorCallback){
        helpCenterProvider.getCategories( object: ZendeskCallback<List<Category>>(){
            override fun onSuccess(categories: List<Category>){
                onSuccess(categories)
            }
            override fun onError(error: ErrorResponse){
                onError(error)
            }
        })
    }

    public fun getSections(category: Long, onSuccess: ListCallback<List<Section>>, onError: ErrorCallback){
        helpCenterProvider.getSections( category, object: ZendeskCallback<List<Section>>(){
            override fun onSuccess(sections: List<Section>){
                onSuccess(sections)
            }
            override fun onError(error: ErrorResponse){
                onError(error)
            }
        })
    }

    public fun getArticles(section: Long, onSuccess: ListCallback<List<Article>>, onError: ErrorCallback){
        helpCenterProvider.getArticles( section, object: ZendeskCallback<List<Article>>(){
            override fun onSuccess(articles: List<Article>){
                onSuccess(articles)
            }
            override fun onError(error: ErrorResponse){
                onError(error)
            }
        })
    }

    public fun getArticle(articleId: Long, onSuccess: SingleCallback<Article>, onError: ErrorCallback){
        helpCenterProvider.getArticle( articleId, object: ZendeskCallback<Article>(){
            override fun onSuccess(article: Article){
                onSuccess(article)
            }
            override fun onError(error: ErrorResponse){
                onError(error)
            }
        })
    }

}