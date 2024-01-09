//
//  File.swift
//  
//
//  Created by Michael Iskandar on 09/01/24.
//

import Foundation
import CommonKit
import UtilityKit

public struct MealsKit {
    public static func registerDependencies() {
        InjectorManager.shared.register(MealFactory.self, factory: { _ in MealsKitFactory()})
    }
}
