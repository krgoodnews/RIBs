//
//  LoggedInBuilder.swift
//  TicTacToe
//
//  Created by Yunsu on 2020/09/05.
//  Copyright © 2020 Uber. All rights reserved.
//

import RIBs

protocol LoggedInDependency: Dependency {
    var loggedInViewController: LoggedInViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class LoggedInComponent: Component<LoggedInDependency>, OffGameDependency, TicTacToeDependency {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var LoggedInViewController: LoggedInViewControllable {
        return dependency.loggedInViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {

    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedInListener) -> LoggedInRouting {
        let component = LoggedInComponent(dependency: dependency)
        let interactor = LoggedInInteractor()
        interactor.listener = listener

        let ticTacTorBuilder = TicTacToeBuilder(dependency: component)
        let offGameBuilder = OffGameBuilder(dependency: component)
        return LoggedInRouter(interactor: interactor,
                              viewController: component.LoggedInViewController, ticTacToeBuilder: ticTacTorBuilder,
                              offGameBuilder: offGameBuilder)
    }
}
