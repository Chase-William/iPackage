//
//  WebView.swift
//  iPackage
//
//  Created by xamarinapple on 4/19/22.
//

import SwiftUI
import WebKit
 
struct WebView: UIViewRepresentable {
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

//struct WebView_Previews: PreviewProvider {
//    static var previews: some View {
//        WebView()
//    }
//}
