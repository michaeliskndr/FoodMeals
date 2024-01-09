//
//  File.swift
//  
//
//  Created by Michael Iskandar on 09/01/24.
//

import Foundation
import UtilityKit

public struct ConnectionKit {
    public static func registerDependencies() {
        InjectorManager.shared.register(MealService.self) { _ in MealAPI() }
    }
}
