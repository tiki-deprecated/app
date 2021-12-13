package com.mytiki.app

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val channel = "com.mytiki.app"
    private val zendeskApi: ZendeskApi = ZendeskApi()


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        zendeskApi.initZendesk(context)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
            call, result -> when(call.method){
                "getZendeskCategories" -> getZendeskCategories(result)
                "getZendeskSection" -> getZendeskSections(call, result)
                "getZendeskArticles" -> getZendeskArticles(call, result)
                "getZendeskArticle" -> getZendeskArticle(call, result)
                else -> result.notImplemented()
            }
        }
    }

    private fun getZendeskCategories(result: MethodChannel.Result) {
        zendeskApi.getCategories(
                {categories -> result.success(categories)},
                {error -> result.error(error.status.toString(), error.reason, error)}
        )
    }

    private fun getZendeskSections(call: MethodCall, result: MethodChannel.Result) {
        val categoryID = if ( call.hasArgument("categoryID") ) call.argument<Any?>("categoryID" )
            else result.error("400", "categoryID argument is missing", null)
        zendeskApi.getSections(
                categoryID as Long,
                {sections -> result.success(sections)},
                {error -> result.error(error.status.toString(), error.reason, error)}
        )
    }

    private fun getZendeskArticles(call: MethodCall, result: MethodChannel.Result) {
        val sectionId = if ( call.hasArgument("sectionId") ) call.argument<Any?>("sectionId" )
        else result.error("400", "sectionId argument is missing", null)
        zendeskApi.getArticles(
                sectionId as Long,
                {sections -> result.success(sections)},
                {error -> result.error(error.status.toString(), error.reason, error)}
        )
    }

    private fun getZendeskArticle(call: MethodCall, result: MethodChannel.Result) {
        val articleId = if ( call.hasArgument("articleId") ) call.argument<Any?>("articleId" )
        else result.error("400", "articleId argument is missing", null)
        zendeskApi.getArticles(
                articleId as Long,
                {sections -> result.success(sections)},
                {error -> result.error(error.status.toString(), error.reason, error)}
        )
    }
}
