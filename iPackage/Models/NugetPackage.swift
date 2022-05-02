//
//  NugetPackageModel.swift
//  iPackage
//
//  Created by xamarinapple on 4/10/22.
//

import Foundation
import CoreData


// How to NSManagedObject + Codable https://www.donnywals.com/using-codable-with-core-data-and-nsmanagedobject/
// final == sealed aka no one can inherit from, simplifies our init(from:) implem
/**
 Model that represents a NugetPackage.
 */
class NugetPackage: NSManagedObject, NugetPackageable {
    
    @NSManaged var id: String // required
    @NSManaged var version: String // required
    @NSManaged var packageDescription: String? // optional -- "description" name already used by NSManagedObject
    // @NSManaged var versions: [NugetVersion] // requried
    @NSManaged var authors: String? // string or [string] optional
    @NSManaged var iconUrl: String? // optional
    @NSManaged var licenseUrl: String? // optional
    @NSManaged var owners: String? // string or [string] optional
    @NSManaged var projectUrl: String? // optional
    @NSManaged var registration: String? // optional
    @NSManaged var summary: String? // optional
    @NSManaged var tags: [String]? // string or [string] optional
    @NSManaged var title: String? // optional
    @NSManaged var totalDownloads: Int // optional -> objective-c doesn't support optional
    @NSManaged var verified: Bool // optional -> objective-c doesn't support optional
    
    
}

struct NugetVersion: Decodable {
    var id: String
    var version: String
    var downloads: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case version
        case downloads
    }
}

//
// ----- IMPORTANT ---- I wanted to hold onto this because it was a pain to implement
//

// How to NSManagedObject + Codable https://www.donnywals.com/using-codable-with-core-data-and-nsmanagedobject/
// final == sealed aka no one can inherit from, simplifies our init(from:) implem
/**
 Model that represents a NugetPackage.
 */
//final class NugetPackage: NSManagedObject, Decodable, NugetPackable {
//
//    @NSManaged public var id: String // required
//    @NSManaged public var version: String // required
//    @NSManaged public var packageDescription: String? // optional -- "description" name already used by NSManagedObject
//    // @NSManaged public var versions: [NugetVersion] // requried
//    @NSManaged public var authors: [String]? // string or [string] optional
//    @NSManaged public var iconUrl: String? // optional
//    @NSManaged public var licenseUrl: String? // optional
//    @NSManaged public var owners: [String]? // string or [string] optional
//    @NSManaged public var projectUrl: String? // optional
//    @NSManaged public var registration: String? // optional
//    @NSManaged public var summary: String? // optional
//    @NSManaged public var tags: [String]? // string or [string] optional
//    @NSManaged public var title: String? // optional
//    @NSManaged public var totalDownloads: Int // optional -> objective-c doesn't support optional
//    @NSManaged public var verified: Bool // optional -> objective-c doesn't support optional
//
//    /**
//     Initialize a new instance of NugetPackage from a decoder.
//     */
//    convenience init(from decoder: Decoder) throws {
//        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext
//        else {
//            throw ModelError.ManagedObjectContextUnavailable
//        }
//        // init NSManagedObject
//        self.init(context: context)
//
//        // parse / decode from json
//        do {
//            // decode structure level
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//            // decode props
//            id = try container.decode(String.self, forKey: .id)
//            version = try container.decode(String.self, forKey: .version)
//            packageDescription = try container.decodeIfPresent(String.self, forKey: .packageDescription)
//            // MARK: need versions here
//            iconUrl = try container.decodeIfPresent(String.self, forKey: .iconUrl)
//            licenseUrl = try container.decodeIfPresent(String.self, forKey: .licenseUrl)
//            // MARK: need owners here
//            projectUrl = try container.decodeIfPresent(String.self, forKey: .projectUrl)
//            registration = try container.decodeIfPresent(String.self, forKey: .registration)
//            summary = try container.decodeIfPresent(String.self, forKey: .summary)
//            // MARK: need tags here
//            title = try container.decodeIfPresent(String.self, forKey: .title)
//            totalDownloads = (try container.decodeIfPresent(Int.self, forKey: .totalDownloads)) ?? 0
//            verified = try (container.decodeIfPresent(Bool.self, forKey: .verified)) ?? false
//        }
//        catch {
//            print(error)
//        }
//    }
//
//    /**
//     Coding mappers.
//     */
//    enum CodingKeys: String, CodingKey {
//        case id
//        case version
//        case packageDescription = "description"
//        // case versions
//        case authors
//        case iconUrl
//        case licenseUrl
//        case owners
//        case projectUrl
//        case registration
//        case summary
//        case tags
//        case title
//        case totalDownloads
//        case verified
//    }
//
//    /**
//     Common errors that may occur related to the model.
//     */
//    enum ModelError: Error {
//        case ManagedObjectContextUnavailable
//    }
//}

/**
 Provides access to the managedObjectContext within the Decodable ctor.
 */
//extension CodingUserInfoKey {
//  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
//}
