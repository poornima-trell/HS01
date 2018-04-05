//
//  AppRenderer.swift
//  HS01_Example
//
//  Created by Poornima on 05/04/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class AppRenderer: NSObject {

    convenience init(bookID _appID: String) {
        //        self.init(navigationController: "", bookID: _appID)
        self.init()
    }
    convenience init(bookID _appID: String, navigationController: UINavigationController) {
        //        self.init(navigationController: _navigationController, bookID: _appID)
        self.init()
    }
    
    convenience init(shelfID shelfId: String) {
        self.init()
    }
    
    func openHSPopUp(_ componentProperties: [AnyHashable: Any]?) {
        let firstTimePopup = componentProperties?["FirstTimePopup"] as? String
        let defaults = UserDefaults.standard
//        if defaults.object(forKey: HS_FIRST_TIME_POPUP_KEY) || firstTimePopup == nil {
//            return
//        }
//        enableLastRead = false
//        processWebViewRequest(URL(string: firstTimePopup ?? ""), mblurb: nil, contextKey: nil, webView: nil, currentPage: nil)
//        if defaults.object(forKey: HS_FIRST_TIME_POPUP_KEY) == nil {
            defaults.set(true, forKey: "HS_FIRST_TIME_POPUP_KEY")
//        }
        defaults.synchronize()
    }

}
