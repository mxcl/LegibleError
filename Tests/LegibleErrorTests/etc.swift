import Foundation
import XCTest

func XCTAssertMatches(_ input: String, _ pattern: String, file: StaticString = #file, line: UInt = #line) {
    do {
        let rx = try NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: input.utf16.count)
        if rx.firstMatch(in: input, range: range) == nil {
            XCTFail("\(input) did not match the provided pattern", file: file, line: line)
        }
    } catch {
        XCTFail("Pattern failed to compile", file: file, line: line)
    }
}

#if !os(macOS) && !os(Linux)
import XCTest

// SwiftPM generates code that is improperly escaped thus we require this to
// compile on iOS & tvOS.
public typealias XCTestCaseEntry = (testCaseClass: XCTestCase.Type, allTests: [(String, (XCTestCase) throws -> Void)])

public func testCase<T: XCTestCase>(_ allTests: [(String, (T) -> () throws -> Void)]) -> XCTestCaseEntry {
    fatalError()
}

public func testCase<T: XCTestCase>(_ allTests: [(String, (T) -> () -> Void)]) -> XCTestCaseEntry {
    fatalError()
}
#endif
