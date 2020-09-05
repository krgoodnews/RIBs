//
//  RootRouterTests.swift
//  TicTacToeTests
//
//  Created by Yunsu on 2020/09/05.
//  Copyright © 2020 Uber. All rights reserved.
//

@testable import TicTacToe

import XCTest

final class RootRouterTests: XCTestCase {

    private var loggedInBuilder: LoggedInBuildableMock!
    private var rootInteractor: RootInteractableMock!
    private var rootRouter: RootRouter!

    override func setUp() {
        super.setUp()

        loggedInBuilder = LoggedInBuildableMock()
        rootInteractor = RootInteractableMock()
        rootRouter = RootRouter(interactor: rootInteractor,
                   viewController: RootViewControllableMock(),
                   loggedOutBuilder: LoggedOutBuildableMock(),
                   loggedInBuilder: loggedInBuilder)
    }

    func test_routeToLoggedIn_verifyInvokeBuilderAttachReturnedRouter() {
        let loggedInRouter = LoggedInRoutingMock(interactable: LoggedInInteractableMock())
        var assignedListener: LoggedInListener? = nil
        loggedInBuilder.buildHandler = { (_ listener: LoggedInListener) -> (LoggedInRouting) in
            assignedListener = listener
            return loggedInRouter
        }

        XCTAssertNil(assignedListener)
        XCTAssertEqual(loggedInBuilder.buildCallCount, 0)
        XCTAssertEqual(loggedInRouter.loadCallCount, 0)

        rootRouter.routeToLoggedIn(withPlayer1Name: "1", player2Name: "2")

        XCTAssertTrue(assignedListener === rootInteractor)
        XCTAssertEqual(loggedInBuilder.buildCallCount, 1)
        XCTAssertEqual(loggedInRouter.loadCallCount, 1)
    }
}
