package com.mytiki.app

import android.content.Context
import com.zendesk.logger.Logger
import com.zendesk.service.ErrorResponse
import com.zendesk.service.ZendeskCallback
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject
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

    fun initZendesk(context : Context) {
        val url = "https://mytikihelp.zendesk.com/"
        val appId = "12abbc10c46d1731876d529d0b90656cc81d416a9452d0be"
        val clientId = "mobile_sdk_client_3beab601d34d787fc05c"

        Logger.setLoggable(true);
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

    fun getZendeskCategories(result: MethodChannel.Result) {
        getCategories(
            {categories -> result.success(categories)},
            {error -> result.error(error.status.toString(), error.reason, error.toString())}
        )
    }

    fun getZendeskSections(call: MethodCall, result: MethodChannel.Result) {
        val categoryID = if ( call.hasArgument("categoryID") ) call.argument<Any?>("categoryID" )
        else result.error("400", "categoryID argument is missing", null)
        getSections(
            categoryID as Long,
            {sections -> result.success(sections)},
            {error -> result.error(error.status.toString(), error.reason, error)}
        )
    }

    fun getZendeskArticles(call: MethodCall, result: MethodChannel.Result) {
        val sectionId = if ( call.hasArgument("sectionId") ) call.argument<Any?>("sectionId" )
        else result.error("400", "sectionId argument is missing", null)
        getArticles(
            sectionId as Long,
            {sections -> result.success(sections)},
            {error -> result.error(error.status.toString(), error.reason, error)}
        )
    }

    fun getZendeskArticle(call: MethodCall, result: MethodChannel.Result) {
        val articleId = if ( call.hasArgument("articleId") ) call.argument<Any?>("articleId" )
        else result.error("400", "articleId argument is missing", null)
        getArticles(
            articleId as Long,
            {sections -> result.success(sections)},
            {error -> result.error(error.status.toString(), error.reason, error)}
        )
    }

    private fun getCategories(onSuccess: ListCallback<ArrayList<Map<Long,String>>>, onError: ErrorCallback){
        helpCenterProvider.getCategories( object: ZendeskCallback<List<Category>>(){
            override fun onSuccess(categories: List<Category>){
                val cats : ArrayList<Map<Long,String>> = ArrayList<Map<Long,String>>()
                categories.forEach{
                    if(it.id != null){
                            cats.add(
                                mapOf(it.id!! to it.name!!)
                            )
                    }
                }
                onSuccess(cats)
            }
            override fun onError(error: ErrorResponse){
                onError(error)
            }
        })
    }

    private fun getSections(category: Long, onSuccess: ListCallback<ArrayList<Map<Long,String>>>, onError: ErrorCallback){
        helpCenterProvider.getSections( category, object: ZendeskCallback<List<Section>>(){
            override fun onSuccess(sections: List<Section>){
                val sectionList : ArrayList<Map<Long,String>> = ArrayList<Map<Long,String>>()
                sections.forEach{
                    if(it.id != null){
                        sectionList.add(
                            mapOf(it.id!! to it.name!!)
                        )
                    }
                }
                onSuccess(sectionList)
            }
            override fun onError(error: ErrorResponse){
                onError(error)
            }
        })
    }

    private fun getArticles(section: Long, onSuccess: ListCallback<ArrayList<Map<Long,String>>>, onError: ErrorCallback){
        helpCenterProvider.getArticles( section, object: ZendeskCallback<List<Article>>(){
            override fun onSuccess(articles: List<Article>){
                val articleList : ArrayList<Map<Long,String>> = ArrayList<Map<Long,String>>()
                articles.forEach{
                    if(it.id != null){
                        articleList.add(
                            mapOf(it.id!! to it.title!!)
                        )
                    }
                }
                onSuccess(articleList)
            }
            override fun onError(error: ErrorResponse){
                onError(error)
            }
        })
    }

    private fun getArticle(articleId: Long, onSuccess: SingleCallback<Map<String,Any>>, onError: ErrorCallback){
        helpCenterProvider.getArticle( articleId, object: ZendeskCallback<Article>(){
            override fun onSuccess(article: Article){
                onSuccess(mapOf<String, Any>(
                    "id" to article.id,
                    "body" to article.body!!
                ))
            }
            override fun onError(error: ErrorResponse){
                onError(error)
            }
        })
    }

}