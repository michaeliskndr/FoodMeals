//
//  Rx+Extension.swift
//  FoodMeals
//
//  Created by Michael Iskandar on 08/01/24.
//

import Foundation
import RxSwift

public extension Observable {
    func subscribeOnNext(run nextSubscriber: ((Element) -> Void)?) -> Disposable {
        subscribe(onNext: nextSubscriber, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    func subscribeOnCompleted(run completedSubscriber: (() -> Void)?) -> Disposable {
        subscribe(onNext: nil, onError: nil, onCompleted: completedSubscriber, onDisposed: nil)
    }
}
