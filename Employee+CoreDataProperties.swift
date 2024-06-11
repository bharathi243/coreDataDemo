//
//  Employee+CoreDataProperties.swift
//  coreDataDemo
//
//  Created by MSC_INDIA on 06/06/24.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var salary: NSNumber?
    @NSManaged public var id: NSNumber?
    @NSManaged public var age: NSNumber?
    
    
    

}

extension Employee : Identifiable {

}
