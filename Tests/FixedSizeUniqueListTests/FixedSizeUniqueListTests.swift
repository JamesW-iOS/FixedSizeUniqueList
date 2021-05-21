import XCTest
@testable import FixedSizeUniqueList

final class FixedSizeUniqueListTests: XCTestCase {
    func testInitNoThrowErrorWithValidSize() {
        let sizes = [1, 3, 10, 999999999]
        for size in sizes {
            XCTAssertNoThrow(try FixedSizeUniqueList<Int>.init(size: size), "Valid sizes should not throw an error on init")
        }
    }

    func testInitThrowWithInvalidSize() {
        do {
            _ = try FixedSizeUniqueList<Int>(size: -1)
        } catch FixedSizeListError.invalidSize {
            return
        } catch {
            XCTFail("Unhandled Error should no occur")
        }

    }

    func testListSizeSetOnInit() {
        let size = 3
        do {
            let list = try FixedSizeUniqueList<Int>(size: size)
            XCTAssertEqual(list.size, size)
        } catch {
            XCTFail("No errors should be thrown")
        }
    }

    func testListEmptyOnInit() {
        do {
            let list = try FixedSizeUniqueList<Int>(size: 3)
            XCTAssertTrue(list.list.isEmpty, "list should be empty on init")
        } catch {
            XCTFail("No Errors should be thrown")
        }
    }

    func testPrependingElementToList() {
        do {
            let list = try FixedSizeUniqueList<Int>(size: 3)
            XCTAssertTrue(list.list.isEmpty, "list should be empty on init")

            list.prepend(2)
            XCTAssertTrue(list.list == [2], "list should now have 2 prepended")

            list.prepend(3)
            XCTAssertTrue(list.list == [3, 2], "list should now have 3 prepended")

            list.prepend(4)
            XCTAssertTrue(list.list == [4, 3, 2], "list should now have 4 prepended")

            list.prepend(5)
            XCTAssertTrue(list.list == [5, 4, 3], "list should now have 5 prepended and have removed 2 to make room")
        } catch {
            XCTFail("No errors should be thrown")
        }
    }

    func testListShouldRemainUnique() {
        do {
            let list = try FixedSizeUniqueList<Int>(size: 3)
            XCTAssertTrue(list.list.isEmpty, "list should be empty on init")

            list.prepend(2)
            XCTAssertTrue(list.list == [2], "list should now have 2 prepended")

            list.prepend(2)
            XCTAssertTrue(list.list == [2], "list should still just be [2]")

            list.prepend(3)
            XCTAssertTrue(list.list == [3, 2], "list should have 3 prepended")

            list.prepend(2)
            XCTAssert(list.list == [2, 3], "list should still be unique but should also have 2 moved to the front")

        } catch {
            XCTFail("No errors should be thrown")
        }
    }

    func testRemovingElementAtInvalidIndexThrows() {
        do {
            let list = try FixedSizeUniqueList<Int>(size: 3)
            XCTAssertTrue(list.list.isEmpty, "list should be empty on init")

            list.prepend(2)
            XCTAssertTrue(list.list == [2], "list should now have 2 prepended")

            list.prepend(3)
            XCTAssertTrue(list.list == [3, 2], "list should now have 3 prepended")

            try list.removeElement(at: 5)
        } catch FixedSizeListError.invalidIndex {
            return
        } catch {
            XCTFail("Unhandled errors should not happen")
        }
    }

    func testRemovingElementAtSpecificIndex() {
        do {
            let list = try FixedSizeUniqueList<Int>(size: 3)
            XCTAssertTrue(list.list.isEmpty, "list should be empty on init")

            list.prepend(2)
            XCTAssertTrue(list.list == [2], "list should now have 2 prepended")

            list.prepend(3)
            XCTAssertTrue(list.list == [3, 2], "list should now have 3 prepended")

            try list.removeElement(at: 0)
            XCTAssertTrue(list.list == [2], "list should have 3 removed")

            list.prepend(3)
            XCTAssertTrue(list.list == [3, 2], "list should now have 3 prepended")

            try list.removeElement(at: 1)
            XCTAssertTrue(list.list == [3], "list should have 2 removed")
        } catch {
            XCTFail("This test should no throw")
        }

    }

    func testRemovingElement() {
        do {
            let list = try FixedSizeUniqueList<Int>(size: 3)
            XCTAssertTrue(list.list.isEmpty, "list should be empty on init")

            list.prepend(2)
            XCTAssertTrue(list.list == [2], "list should now have 2 prepended")

            list.prepend(3)
            XCTAssertTrue(list.list == [3, 2], "list should now have 3 prepended")

            list.removeElement(element: 2)
            XCTAssertTrue(list.list == [3], "2 should be removed from the list")
        } catch {
            XCTFail("This test should no throw")
        }
    }
}
