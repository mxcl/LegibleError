@testable import LegibleError
import XCTest

class Edgcases: XCTestCase {
    func test_vanilla_NSError() {
        let Foo = { NSError(domain: "a", code: 1) }
        XCTAssertEqual(Foo().legibleDescription, "a(1)")
        XCTAssertEqual(Foo().legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (a.1)")
    #if !os(Linux) || swift(>=5.1)
        XCTAssertEqual(Foo().localizedDescription, "\(theOperationCouldNotBeCompleted) (a error 1.)")
    #else
        XCTAssertEqual(Foo().localizedDescription, theOperationCouldNotBeCompleted)
    #endif
    }

    func test_derived_NSError() {
        class Foo: NSError {
            convenience init() {
                self.init(domain: "a", code: 1)
            }
        }

        XCTAssertEqual(Foo().legibleDescription, "a(1)")
        XCTAssertEqual(Foo().legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (a.1)")
    #if !os(Linux) || swift(>=5.1)
        XCTAssertEqual(Foo().localizedDescription, "\(theOperationCouldNotBeCompleted) (a error 1.)")
    #else
        XCTAssertEqual(Foo().localizedDescription, theOperationCouldNotBeCompleted)
    #endif
    }

    func test_derived_annotated_NSError() {
        class Foo: NSError {
            convenience init() {
                self.init(domain: "a", code: 1, userInfo: [
                    NSLocalizedDescriptionKey: "Foobar"
                ])
            }
        }

        XCTAssertEqual(Foo().legibleDescription, "a(1)")
        XCTAssertEqual(Foo().legibleLocalizedDescription, "Foobar")
        XCTAssertEqual(Foo().localizedDescription, "Foobar")
    }

    func test_derived_underlying_NSError() {
        class Foo: NSError {
            convenience init() {
                self.init(domain: "a", code: 1, userInfo: [
                    NSUnderlyingErrorKey: Foo(domain: "b", code: 2, userInfo: [
                        NSLocalizedDescriptionKey: "Foobar"
                    ])
                ])
            }
        }

        XCTAssertEqual(Foo().legibleDescription, "a(1, b(2))")
        XCTAssertEqual(Foo().legibleLocalizedDescription, "Foobar")
    #if !os(Linux) || swift(>=5.1)
        XCTAssertEqual(Foo().localizedDescription, "\(theOperationCouldNotBeCompleted) (a error 1.)")
    #else
        XCTAssertEqual(Foo().localizedDescription, theOperationCouldNotBeCompleted)
    #endif
    }

    func test_CocoaError() {
        let err = CocoaError.error(.coderInvalidValue)
        let msg = "The data couldn’t be written because it isn’t in the correct format."

        XCTAssertEqual(err.legibleDescription, "NSCocoaErrorDomain(4866)")
    #if !os(Linux)
        XCTAssertEqual(err.legibleLocalizedDescription, msg)
        XCTAssertEqual(err.localizedDescription, msg)
    #elseif swift(>=5.1)
        XCTAssertEqual(err.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (NSCocoaErrorDomain.4866)")
        XCTAssertEqual(err.localizedDescription, "\(theOperationCouldNotBeCompleted) The data isn’t in the correct format.")
    #else
        XCTAssertEqual(err.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (NSCocoaErrorDomain.4866)")
        XCTAssertEqual(err.localizedDescription, theOperationCouldNotBeCompleted)
    #endif
    }
}
