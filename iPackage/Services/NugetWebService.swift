//
//  NugetWebService.swift
//  iPackage
//
//  Created by xamarinapple on 4/27/22.
//

import Foundation
import SwiftUI
import Alamofire

class NugetWebService {
    
    static func syncWithRemote(package: NugetPackage) {
        AF.request("https://azuresearch-usnc.nuget.org/query/?q=\(package.id)&take=1&prerelease=true", method: .get).responseString { res in
            let decoder = JSONDecoder()
            do {
                let resPackage = try decoder.decode(NugetRoot.self, from: res.data!).packages.first
                
                guard let checkedPackage = resPackage else {
                    print("Null was returned from a query in syncWithRemote.")
                    return
                }
                
                package.version = checkedPackage.version
                package.packageDescription = checkedPackage.packageDescription
                package.authors = checkedPackage.authors
                package.iconUrl = checkedPackage.iconUrl
                package.licenseUrl = checkedPackage.licenseUrl
                package.owners = checkedPackage.owners
                package.projectUrl = checkedPackage.projectUrl
                package.registration = package.registration
                package.summary = package.summary
                package.tags = package.tags
                package.title = package.title
                package.totalDownloads = package.totalDownloads
                package.verified = package.verified
            
            }
            catch {
                print(error)
            }
        }
    }
    
    func getPackage(name: String, type: QueryBy) async -> [NugetPackageDTO]? {
        var packages: [NugetPackageDTO]?
        // Create request object
        AF.request("https://azuresearch-usnc.nuget.org/query/?q=\(name)&take=5&packageType=\(type == QueryBy.Dependency ? "Dependency" : "Template")", method: .get).responseString { res in
            let decoder = JSONDecoder()
            // decoder.userInfo[CodingUserInfoKey.managedObjectContext] = moc
            packages = try! decoder.decode(NugetRoot.self, from: res.data!).packages
        }
        
//        var packages: [NugetPackageDTO]?
//
//        // Make request
//        await request.responseString { res in
//            let decoder = JSONDecoder()
//            // decoder.userInfo[CodingUserInfoKey.managedObjectContext] = moc
//            packages = try! decoder.decode(NugetRoot.self, from: res.data!).packages
//        }
        
        return packages
        
        //let decoder = JSONDecoder()
        // decoder.userInfo[CodingUserInfoKey.managedObjectContext] = moc
        //return try! decoder.decode(NugetRoot.self, from: result.data!).packages
    }
}
