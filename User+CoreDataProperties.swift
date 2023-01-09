//
//  User+CoreDataProperties.swift
//  EvaluacionIOS
//
//  Created by Wilder Lopez on 12/23/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var firstLastname: String?
    @NSManaged public var secondLastname: String?
    @NSManaged public var gender: String?

}

extension User : Identifiable {

}
