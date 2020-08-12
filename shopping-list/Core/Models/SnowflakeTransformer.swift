//
//  SnowflakeTransformer.swift
//  shopping-list
//
//  Created by Mason Phillips on 8/12/20.
//

import Foundation
import CoreData
import LibSnowflake

extension List {
    var identifier: Snowflake {
        get { return self.id as Snowflake }
        set { self.id = newValue }
    }
}
