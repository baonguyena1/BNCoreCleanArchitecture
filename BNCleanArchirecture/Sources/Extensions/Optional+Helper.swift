//
//  Optional+Helper.swift
//  BNCleanArchirecture
//
//  Created by Storm Ng on 2020/03/08.
//  Copyright © 2020 Storm Ng. All rights reserved.
//

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
