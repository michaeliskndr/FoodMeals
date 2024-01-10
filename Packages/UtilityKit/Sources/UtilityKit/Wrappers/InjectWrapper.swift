//
//  InjectWrapper.swift
//  FoodMeals
//
//  Created by Michael Iskandar on 09/01/24.
//

import Foundation
import Swinject

@propertyWrapper
public class Inject<T> {
    public lazy var wrappedValue: T = InjectorManager.shared.resolve(T.self)!
    public init() {}
}
