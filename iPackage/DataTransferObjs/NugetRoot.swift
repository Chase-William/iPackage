//
//  NugetRoot.swift
//  iPackage
//
//  Created by xamarinapple on 4/17/22.
//

import Foundation

struct NugetRoot: Decodable {
    //var nugetContext: NugetContext
    
    var packages: [NugetPackageDTO]
    
    enum CodingKeys: String, CodingKey {
        case packages = "data"
    }
}

//struct NugetContext {
//    var vocab: String
//    var base: String
//}
