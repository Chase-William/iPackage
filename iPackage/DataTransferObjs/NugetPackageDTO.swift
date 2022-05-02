//
//  NugetPackageDTO.swift
//  iPackage
//
//  Created by xamarinapple on 4/19/22.
//

import Foundation

struct NugetPackageDTO: NugetPackageable, Decodable {
    var id: String = ""
    var version: String = ""
    var packageDescription: String?
    // @NSManaged public var versions: [NugetVersion] // requried
    var authors: String?
    var iconUrl: String?
    var licenseUrl: String?
    var owners: String?
    var projectUrl: String?
    var registration: String?
    var summary: String?
    var tags: [String]?
    var title: String?
    var totalDownloads: Int = 0
    var verified = false
    
    /**
     Coding mappers.
     */
    enum CodingKeys: String, CodingKey {
        case id
        case version
        case packageDescription = "description"
        // case versions
        case authors
        case iconUrl
        case licenseUrl
        case owners
        case projectUrl
        case registration
        case summary
        case tags
        case title
        case totalDownloads
        case verified
    }
    
    init() { }
    
    /**
     Initialize a new instance of NugetPackage from a decoder.
     */
    init(from decoder: Decoder) throws {
        // parse / decode from json
        do {
            // decode structure level
            let container = try decoder.container(keyedBy: CodingKeys.self)
            // decode props
            id = try container.decode(String.self, forKey: .id)
            version = try container.decode(String.self, forKey: .version)
            packageDescription = try container.decodeIfPresent(String.self, forKey: .packageDescription)
            // MARK: need versions here
            iconUrl = try container.decodeIfPresent(String.self, forKey: .iconUrl)
            licenseUrl = try container.decodeIfPresent(String.self, forKey: .licenseUrl)
            do {
                authors = try container.decodeIfPresent(String.self, forKey: .authors)
            }
            catch {
                let tempCol = try container.decodeIfPresent([String].self, forKey: .authors)
                authors = tempCol?.joined(separator: ",") // concat into a comma sperated string
            }
            
            do {
                owners = try container.decodeIfPresent(String.self, forKey: .owners)
            }
            catch {
                let tempCol = try container.decodeIfPresent([String].self, forKey: .owners)
                owners = tempCol?.joined(separator: ",") // concat into a comma sperated string
            }
            
            projectUrl = try container.decodeIfPresent(String.self, forKey: .projectUrl)
            registration = try container.decodeIfPresent(String.self, forKey: .registration)
            summary = try container.decodeIfPresent(String.self, forKey: .summary)
            // MARK: need tags here
            title = try container.decodeIfPresent(String.self, forKey: .title)
            totalDownloads = (try container.decodeIfPresent(Int.self, forKey: .totalDownloads)) ?? 0
            verified = try (container.decodeIfPresent(Bool.self, forKey: .verified)) ?? false
        }
        catch {
            print(error)
        }
    }
}
