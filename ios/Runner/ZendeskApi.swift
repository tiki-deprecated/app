//
//  ZendeskApi.swift
//  Runner
//
//  Created by Ricardo on 13/12/21.
//

import Foundation
import ZendeskCoreSDK

class ZendeskApi {

    private var helpCenterProvider: HelpCenterProvider?

//URL: https://mytikihelp.zendesk.com/
//App ID: 12abbc10c46d1731876d529d0b90656cc81d416a9452d0be
//Client ID: mobile_sdk_client_3beab601d34d787fc05c
    
    public init() {
        CoreLogger.enabled = true
        CoreLogger.logLevel = .debug

        Zendesk.initialize(
            appId: "7e550831c951ec99f5d1c80097c826423a31cf5cea65e8a9",
            clientId: "mobile_sdk_client_628da91557d8d53c58ca",
            zendeskUrl: "https://brgweb.zendesk.com"
        )
      
        let identity = Identity.createAnonymous()
        Zendesk.instance?.setIdentity(identity)
        
        helpCenterProvider = ZDKHelpCenterProvider()
    }
    
    func getCategory(categoryId: UInt64){
        helpCenterProvider
    }
}

