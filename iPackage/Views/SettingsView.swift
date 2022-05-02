//
//  SettingsView.swift
//  iPackage
//
//  Created by xamarinapple on 4/24/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        Form {
            Text("Saved Packages Settings")
                .font(.title)
            VStack {
                Toggle(isOn: $settings.isAutoSyncOn) {
                    Text(settings.isAutoSyncOn ? "Automatic Package Sync" : "Manual Package Sync")
                }
                Text("Toggles whether the application will automatically fetch updates from a remote server to ensure your packages are update to date. This will put extra strain on your device's battery life.")
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                
                Toggle(isOn: $settings.isWebViewReadMeEnabled) {
                    Text(settings.isWebViewReadMeEnabled ? "External ReadMe" : "Inline ReadMe")
                }
                Text("Toggles whether a package's readme will be displayed inline or instead be available through an link.")
            }
            .padding()
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
