//
//  ObservableType+Helper.swift
//  BNCleanArchirecture
//
//  Created by Storm Ng on 2020/03/08.
//  Copyright © 2020 Storm Ng. All rights reserved.
//

import RxSwift
import RxCocoa

extension ObservableType {
    public func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    
    public func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
    
    public func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
    
    public func mapToOptional() -> Observable<Element?> {
        return map { value -> Element? in value }
    }
    
    public func unwrap<T>() -> Observable<T> where Element == T? {
        return flatMap { Observable.from(optional: $0) }
    }
}

extension ObservableType where Element == Bool {
    public func not() -> Observable<Bool> {
        return map(!)
    }
    
    public static func or(_ sources: Observable<Bool>...) -> Observable<Bool> {
            return Observable.combineLatest(sources)
                .map { $0.reduce(false) { $0 || $1 } }
    }
    
    public static func and(_ sources: Observable<Bool>...) -> Observable<Bool> {
            return Observable.combineLatest(sources)
                .map { $0.reduce(true) { $0 && $1 } }
    }
}
