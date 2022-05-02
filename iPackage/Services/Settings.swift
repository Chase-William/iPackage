//
//  Store.swift
//  iPackage
//
//  Created by xamarinapple on 4/27/22.
//

import Foundation

class Settings: ObservableObject {
    @Published var isAutoSyncOn: Bool {
        didSet {
            UserDefaults.standard.setValue(isAutoSyncOn, forKey: "isAutoSyncOn")
        }
    }
    
    @Published var isWebViewReadMeEnabled: Bool {
        didSet {
            UserDefaults.standard.setValue(isWebViewReadMeEnabled, forKey: "isWebViewReadMeEnabled")
        }
    }
    
    init() {
        self.isAutoSyncOn = UserDefaults.standard.bool(forKey: "isAutoSyncOn")
        self.isWebViewReadMeEnabled = UserDefaults.standard.bool(forKey: "isWebViewReadMeEnabled")
    }
}
