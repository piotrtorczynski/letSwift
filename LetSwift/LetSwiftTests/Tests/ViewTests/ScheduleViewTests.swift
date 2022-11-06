//
//  ScheduleViewTests.swift
//  LetSwiftTests
//
//  Created by Piotr Torczynski on 05/11/2022.
//

import Combine
import Cuckoo
import Resolver
import Testing
import ViewInspector
import XCTest

@testable import LetSwift

final class ScheduleViewTests: TestCase {

    private let subject = PassthroughSubject<[Race], Error>()

    override func setUp() {
        super.setUp()

        let mock = MockEargastAPIServiceProtocol()

        stub(mock) { mock in
            when(mock.getCurrentSchedule())
                .thenReturn(subject.eraseToAnyPublisher())
        }

        Resolver.register { mock }
            .implements(EargastAPIServiceProtocol.self)
    }

    func testLoadingView() throws {
        let viewModel = ScheduleViewModel()
        viewModel.state = .loading

        let view = ScheduleView(viewModel: viewModel)

        ViewHosting.host(view: view)

        XCTAssertNotNil(try view.inspect().find(viewWithId: "circlural_view"))
    }

    func testErrorState() throws {
        let viewModel = ScheduleViewModel()

        let view = ScheduleView(viewModel: viewModel)

        ViewHosting.host(view: view)

        viewModel.state = .error(TestError.none)

        XCTAssertNotNil(try view.inspect().find(viewWithId: "try_again_view"))
    }
}
