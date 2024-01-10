//
//  RxWrapper.swift
//  FoodMeals
//
//  Created by Michael Iskandar on 08/01/24.
//

import Foundation
import RxSwift

public protocol ObservableWrapper: AnyObject {
    associatedtype Observed
    var wrappedValue: Observed { get set }
    var projectedValue: Observable<Observed> { get }
    func onNext(_ value: Observed)
    func onError(_ error: Error)
    func onCompleted()
}

@propertyWrapper
public class PublishWrapper<Observed>: ObservableWrapper {
    var subject: PublishSubject<Observed> = PublishSubject.init()
    
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var _wrappedValue: Observed!
    
    public var wrappedValue: Observed {
        get {
            _wrappedValue
        } set {
            _wrappedValue = newValue
            subject.onNext(newValue)
        }
    }
    
    public var projectedValue: RxSwift.Observable<Observed> {
        subject
    }
    
    public init(wrappedValue: Observed) {
        self.wrappedValue = wrappedValue
    }
    
    public func onNext(_ value: Observed) {
        _wrappedValue = value
        subject.onNext(value)
    }
    
    public func onError(_ error: Error) {
        subject.onError(error)
    }
    
    public func onCompleted() {
        subject.onCompleted()
    }
 }

@propertyWrapper
public class BehaviourWrapper<Observed>: ObservableWrapper {
    lazy var subject: BehaviorSubject<Observed> = BehaviorSubject.init(value: _wrappedValue)
    
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var _wrappedValue: Observed!
    
    public var wrappedValue: Observed {
        get {
            _wrappedValue
        } set {
            _wrappedValue = newValue
            subject.onNext(newValue)
        }
    }
    
    public var projectedValue: Observable<Observed> {
        subject
    }
    
    public init(wrappedValue: Observed) {
        self.wrappedValue = wrappedValue
    }
    
    public func onNext(_ value: Observed) {
        _wrappedValue = value
        subject.onNext(value)
    }
    
    public func onError(_ error: Error) {
        subject.onError(error)
    }
    
    public func onCompleted() {
        subject.onCompleted()
    }
 }
