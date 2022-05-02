//
//  PackageDetailView.swift
//  iPackage
//
//  Created by xamarinapple on 4/19/22.
//

import SwiftUI
import SwiftUIFlowLayout
import Foundation
import UIKit
import Combine

struct PackageDetailView: View {
    @FetchRequest(sortDescriptors: []) var packages: FetchedResults<NugetPackage>
    @Environment(\.managedObjectContext) private var moc
    @EnvironmentObject var settings: Settings
    
    var package: NugetPackageable
    
    @State var hasSyncStarted = false

    private var isSaved: Bool {
        packages.contains { $0.id.elementsEqual(package.id) }
    }
    
    @State var timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            VStack {
                if package.iconUrl != nil {
                    AsyncImage(
                        url: URL(string: package.iconUrl!),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 128, maxHeight: 128)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    .cornerRadius(5)
                    .padding()
                }
                
                Text(package.id)
                    .fontWeight(.heavy)
        
                Text("Current Version: \(package.version)")
                    .fontWeight(.light)
                
                if package.packageDescription != nil {
                    Text(package.packageDescription!)
                        .foregroundColor(.gray)
                        .fontWeight(.light)
                        .padding()
                }
            
                if package.owners != nil { // Display owner information if available
                    if package.owners!.split(separator: ",").count == 1 {
                        HStack {
                            Text("Owner:")
                            Text(package.owners!)
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                                .padding(7)
                                .background(RoundedRectangle(cornerRadius: 15)
                                                .foregroundColor(.yellow))
                        }
                    } else {
                        let owners = package.owners!.split(separator: ",")
                        VStack(alignment: .leading) {
                            Text("Owners:")
                            FlowLayout(mode: .scrollable,
                                       items: owners,
                                       itemSpacing: 4) {
                                  Text($0)
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)
                                    .padding(7)
                                    .background(RoundedRectangle(cornerRadius: 15)
                                                    .foregroundColor(.yellow))
                                }
                        }
                        .padding()
                    }
                }

                if package.authors != nil { // Display author information if available
                    if package.authors!.split(separator: ",").count == 1 {
                        HStack {
                            Text("Author:")
                                .alignmentGuide(.leading, computeValue: { d in d[.leading]})
                            Text(package.authors!)
                                .alignmentGuide(.trailing, computeValue: { d in d[.trailing]})
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                                .padding(7)
                                .background(RoundedRectangle(cornerRadius: 15)
                                                .foregroundColor(.yellow))
                        }
                    } else {
                        let authors = package.authors!.split(separator: ",")
                        HStack {
                            Text("Authors:")
                            FlowLayout(mode: .scrollable,
                                       items: authors,
                                       itemSpacing: 4) {
                                Text($0)
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)
                                    .padding(7)
                                    .background(RoundedRectangle(cornerRadius: 15)
                                                    .foregroundColor(.yellow))
                            }
                        }
                    }
                }
                
    //            if package.owners?.count == 1 {
    //
    //            }
    //            NavigationLink {
    //
    //            } label: {
    //                Button {
    //
    //                } label: {
    //                    Text("Version")
    //                }
    //            }
                
    //            NavigationLink {
    //                PackageVersionsView()
    //            } label: {
    //                package.ver
    //            }
                
                if package.projectUrl != nil {
                    if settings.isWebViewReadMeEnabled {
                        Link("Visit ReadMe", destination: URL(string: package.projectUrl!)!)
                            .padding()
                    } else {
                        WebView(url: URL(string: package.projectUrl!)!)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                HStack {
                    if !settings.isAutoSyncOn && package is NugetPackage {
                        Button {
                            timer = Timer.publish(every: 0.9, on: .main, in: .common).autoconnect()
                            NugetWebService.syncWithRemote(package: package as! NugetPackage)
                            
                            withAnimation(.spring()) {
                                hasSyncStarted = true
                            }
                        } label: {
                            Image(systemName: "square.and.arrow.down")
                        }.onReceive(timer) { _ in
                            self.timer.upstream.connect().cancel()
                            withAnimation(.spring()) {
                                hasSyncStarted = false
                            }
                        }
                    }
                    
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gear")
                    }
                    
                    Button { // Save / Delete from bookmarks
                        
                        if isSaved { // Already exist
                            let toBeDeleted = packages.first { $0.id.elementsEqual(package.id) }
                            moc.delete(toBeDeleted!)
                            return
                        }
                        // Doesn't exist in CoreData
                        let savedPackage = NugetPackage(context: moc)
                        savedPackage.id = package.id
                        savedPackage.version = package.version
                        savedPackage.packageDescription = package.packageDescription
                        savedPackage.authors = package.authors
                        savedPackage.iconUrl = package.iconUrl
                        savedPackage.licenseUrl = package.licenseUrl
                        savedPackage.owners = package.owners
                        savedPackage.projectUrl = package.projectUrl
                        savedPackage.registration = package.registration
                        savedPackage.summary = package.summary
                        savedPackage.tags = package.tags
                        savedPackage.title = package.title
                        savedPackage.totalDownloads = package.totalDownloads
                        savedPackage.verified = package.verified
                        
                        do {
                            try moc.save()
                        } catch {
                            print(error)
                        }
                    } label: {
                        Image(systemName: isSaved ? "bookmark.fill" : "bookmark") // stroke == !bookmarked, fill == bookedmarked
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
            
            if hasSyncStarted {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 150, height: 60, alignment: .bottom)
                     .foregroundColor(.blue)
                     .opacity(0.7)
                     .overlay(
                        HStack {
                            Text("Synchronizing...")
                        }
                     )
                     //.transition(.scale(scale: 0, anchor: .bottom))
                     //.transition(.offset(x: -600, y: 0))
                     .transition(.offsetScaleOpacity)
            }
        } //zstack
    }
}

extension AnyTransition {
    static var offsetScaleOpacity: AnyTransition {
        AnyTransition
            .offset(x: -600, y:0)
            .combined(with: .scale)
            .combined(with: .opacity)
    }
}

//struct PackageDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PackageDetailView()
//    }
//}
