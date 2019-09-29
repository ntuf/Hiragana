//
//  Configuration.swift
//  Hiragana
//
//  Created by hiroyuki tomiduka on 2019/09/29.
//  Copyright © 2019 ntuf. All rights reserved.
//

import Foundation

struct Configuration {
    static let shared = Configuration()

    private let config: [AnyHashable: Any] = {
        let path = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let plist = NSDictionary(contentsOfFile: path) as! [AnyHashable: Any]
        return plist["AppConfig"] as! [AnyHashable: Any]
    }()

    let goolabsAPI_hiragana_URL: String
    let goolabsAPI_app_id: String

    private init() {
        goolabsAPI_hiragana_URL = config["Goo Labs API hiragana URL"] as! String
        goolabsAPI_app_id = config["Goo Labs API app_id"] as! String
    }
}
