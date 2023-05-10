//
//  NSManagedObject+Additions.swift
//  JPMC MCoE
//
//  Created by Stephen Chase on 09/05/2023.
//

import CoreData

extension NSManagedObject {
    class var entityName: String { Self.entity().name! }
    public var entityName: String { return type(of: self).entityName }
}
