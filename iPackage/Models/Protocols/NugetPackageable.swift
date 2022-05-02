//
//  NugetPackagable.swift
//  iPackage
//
//  Created by xamarinapple on 4/19/22.
//

import Foundation

/**
 Declares the needed members for a NugetPackage that can be implemented in both structs / classes.
 */
protocol NugetPackageable {
    var id: String { get set }// required
    var version: String { get set } // required
    var packageDescription: String? { get set } // optional -- "description" name already used by NSManagedObject
    //var versions: [NugetVersion] // requried
    var authors: String? { get set } // string or [string] optional
    var iconUrl: String? { get set } // optional
    var licenseUrl: String? { get set } // optional
    var owners: String? { get set } // string or [string] optional -- I am not making a new table for this and pk fk stuff, out of scope imho
    var projectUrl: String? { get set } // optional
    var registration: String? { get set } // optional
    var summary: String? { get set } // optional
    var tags: [String]? { get set } // string or [string] optional
    var title: String? { get set } // optional
    var totalDownloads: Int { get set } // optional -> objective-c doesn't support optional
    var verified: Bool { get set } // optional -> objective-c doesn't support optional
}
