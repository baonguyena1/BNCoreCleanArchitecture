//
//  Driver+Helper.swift
//  BNCleanArchirecture
//
//  Created by Storm Ng on 2020/03/08.
//  Copyright © 2020 Storm Ng. All rights reserved.
//

import RxCocoa

extension SharedSequenceConvertibleType {
    
    public func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
    
    public func mapToOptional() -> SharedSequence<SharingStrategy, Element?> {
        return map { value -> Element? in value }
    }
    
    public func unwrap<T>() -> SharedSequence<SharingStrategy, T> where Element == T? {
        return flatMap { SharedSequence.from(optional: $0) }
    }
}

extension SharedSequenceConvertibleType where Element == Bool {
    public func not() -> SharedSequence<SharingStrategy, Bool> {
        return map(!)
    }
    
    public static func or(_ sources: SharedSequence<DriverSharingStrategy, Bool>...)
        -> SharedSequence<DriverSharingStrategy, Bool> {
            return Driver.combineLatest(sources)
                .map { $0.reduce(false) { $0 || $1 } }
    }
    
    public static func and(_ sources: SharedSequence<DriverSharingStrategy, Bool>...)
        -> SharedSequence<DriverSharingStrategy, Bool> {
            return Driver.combineLatest(sources)
                .map { $0.reduce(true) { $0 && $1 } }
    }
}
