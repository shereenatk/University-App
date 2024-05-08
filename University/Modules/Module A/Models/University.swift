//
//  University.swift
//  University
//
//  Created by ios on 07/05/2024.
//

import Foundation
import CoreData

struct UniversityDTO: Codable {
    let stateProvince: String?
    let domains: [String]?
    let webPages: [String]?
    let name: String?
    let alphaTwoCode: String?
    let country: String?

    enum CodingKeys: String, CodingKey {
        case stateProvince = "state-province"
        case domains
        case webPages = "web_pages"
        case name
        case alphaTwoCode = "alpha_two_code"
        case country
    }
}


extension University {
    func update(with dto: UniversityDTO) {
            stateProvince = dto.stateProvince
            // Convert arrays to NSSet
//            domains = dto.domains != nil ? NSSet(array: dto.domains!) : nil
//            webPages = dto.webPages != nil ? NSSet(array: dto.webPages!) : nil
            name = dto.name
            alphaTwoCode = dto.alphaTwoCode
            country = dto.country
        }
}

//class University: NSManagedObject, Decodable {
//    @NSManaged var id: String
//    @NSManaged var stateProvince: String?
//    @NSManaged var domains: [String]?
//    @NSManaged var webPages: [String]?
//    @NSManaged var name: String
//    @NSManaged var alphaTwoCode: String?
//    @NSManaged var country: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case stateProvince = "state-province"
//        case domains
//        case webPages = "web_pages"
//        case name
//        case alphaTwoCode = "alpha_two_code"
//        case country
//    }
//
//    required convenience init(from decoder: Decoder) throws {
//        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
//            fatalError("No context provided for decoding")
//        }
//        guard let entity = NSEntityDescription.entity(forEntityName: "University", in: context) else {
//            fatalError("Failed to find entity description")
//        }
//        self.init(entity: entity, insertInto: context)
//        
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(String.self, forKey: .id)
//        stateProvince = try container.decodeIfPresent(String.self, forKey: .stateProvince)
//        domains = try container.decodeIfPresent([String].self, forKey: .domains)
//        webPages = try container.decodeIfPresent([String].self, forKey: .webPages)
//        name = try container.decode(String.self, forKey: .name)
//        alphaTwoCode = try container.decodeIfPresent(String.self, forKey: .alphaTwoCode)
//        country = try container.decodeIfPresent(String.self, forKey: .country)
//    }
//}
//extension CodingUserInfoKey {
//    static let context = CodingUserInfoKey(rawValue: "context")!
//}

//import RealmSwift
//
//class University: Object, Codable {
//    @objc dynamic var id = UUID().uuidString
//    @objc dynamic var stateProvince: String?
//    var domains = List<String>()
//    var webPages = List<String>()
//    @objc dynamic var name: String = ""
//    @objc dynamic var alphaTwoCode: String?
//    @objc dynamic var country: String?
//
//    override static func primaryKey() -> String? {
//        return "id" 
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case stateProvince = "state-province"
//        case domains
//        case webPages = "web_pages"
//        case name
//        case alphaTwoCode = "alpha_two_code"
//        case country
//    }
//}
//
