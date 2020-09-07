//
//  LoggedInActionableItem.swift
//  TicTacToe
//
//  Created by Yunsu on 2020/09/07.
//  Copyright © 2020 Uber. All rights reserved.
//

import Foundation
import RxSwift

public protocol LoggedInActionableItem: class {
    func launchGame(with id: String?) -> Observable<(LoggedInActionableItem, ())>
}
