//
//  SearchView.swift
//  iPackage
//
//  Created by xamarinapple on 4/19/22.
//

import SwiftUI
import CoreData
import Alamofire

enum QueryBy {
    case Dependency
    case Template
}

struct SearchView: View {
    @State var srcPackages: [NugetPackageDTO]?
    @State var selectedQueryParam = QueryBy.Dependency
    @State var queryBy = "Name"
    
    var nugetWebService = NugetWebService()
    
    /**
     Query string user enters.
     */
    @State private var queryStr = ""
    
    /**
     Filtered packages via query string.
     */
    var searchResults: [NugetPackageDTO]? {
        if queryStr.isEmpty {
            return srcPackages
        } else {
            return srcPackages?.filter { $0.id.contains(queryStr) }
        }
    }
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.systemBlue,
            .font: UIFont(name: "ArialRoundedMTBold", size: 30)!
        ]

        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.systemBlue,
            .font: UIFont(name: "ArialRoundedMTBold", size: 20)!
        ]
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        
        navBarAppearance.setBackIndicatorImage(
            UIImage(systemName: "arrow.turn.up.left"),
            transitionMaskImage: UIImage(systemName: "arrow.turn.up.left")
        )
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if searchResults == nil {
                    Text("Search for \(queryStr)")
                        .searchable(text: $queryStr, prompt: Text("search for \(queryBy)"))
                        .onSubmit(of: .search) {
                            Task {
                                await search()
                                DispatchQueue.main.async {
                                    queryStr = ""
                                }
                            }
                        }
                } else {
                    List(searchResults!, id: \.id) { package in
                        PackageRow(package: package)
                    }
                    .searchable(text: $queryStr, prompt: Text("search for \(queryBy)"))
                    .onSubmit(of: .search) {
                        Task {
                            await search()
                            DispatchQueue.main.async {
                                queryStr = ""
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Picker(selection: $selectedQueryParam, label: EmptyView()) {
                        Text("Dependency")
                            .tag(QueryBy.Dependency)
                        Text("Template")
                            .tag(QueryBy.Template)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: selectedQueryParam) { value in
                        switch value {
                        case QueryBy.Dependency:
                            queryBy = "Dependencies"
                            break
                        case QueryBy.Template:
                            queryBy = "Templates"
                            break
                        }
                    }
                }
            }
            .navigationTitle(Text("Package Browser"))
        }
        .tabItem {
            Image(systemName: "magnifyingglass")
        }
        .tag(Views.Search)
    }
    
    
    func search() async {
        AF.request("https://azuresearch-usnc.nuget.org/query/?q=\(queryStr)&take=20&packageType=\(selectedQueryParam == QueryBy.Dependency ? "Dependency" : "Template")&prerelease=true", method: .get).responseString { res in
            let decoder = JSONDecoder()
            // decoder.userInfo[CodingUserInfoKey.managedObjectContext] = moc
            do {
                srcPackages = try decoder.decode(NugetRoot.self, from: res.data!).packages
            }
            catch {
                print(error)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
