//
//  AppStep.swift
//  shopping-list
//
//  Created by Mason Phillips on 8/11/20.
//

import RxFlow
import LibSnowflake

enum AppStep: Step {
    case allLists
    case list(id: Snowflake)
    case create
    case done
}
