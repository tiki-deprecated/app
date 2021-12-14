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
                "getZendeskCategories" -> zendeskApi.getZendeskCategories(result)
                "getZendeskSection" -> zendeskApi.getZendeskSections(call, result)
                "getZendeskArticles" -> zendeskApi.getZendeskArticles(call, result)
                "getZendeskArticle" -> zendeskApi.getZendeskArticle(call, result)
                else -> result.notImplemented()
            }
        }
    }


}
