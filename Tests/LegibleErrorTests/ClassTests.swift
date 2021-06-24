@testable import LegibleError
import XCTest

public class PublicFoo: Error {
    let a = "a"
}

class InternalFoo: Error {
    let a = "a"
}

class PrivateFoo: Error {
    let a = "a"
}

class ClassTests: XCTestCase {
    func test_local_Swift_class() {

        //FIXME!

        class Foo: Error {
            let a = "a"
        }

        let foo = Foo()

    #if os(macOS) && swift(>=5.0)
        XCTAssertMatches(
            foo.legibleDescription,
            "^LegibleErrorTests\\.ClassTests\\.\\(unknown context at \\$.+\\)\\.\\(unknown context at \\$.+\\)\\.Foo\\(1\\)$")
        XCTAssertMatches(
            foo.legibleLocalizedDescription,
            "^\(theOperationCouldNotBeCompleted) \\(LegibleErrorTests\\.ClassTests\\.\\(unknown context at \\$.+\\)\\.\\(unknown context at \\$.+\\)\\.Foo\\.1\\)$")
    #else
        XCTAssertEqual(foo.legibleDescription, "Foo")
        XCTAssertEqual(foo.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (Foo)")
    #endif
    }

    func test_public_Swift_class() {
        let foo = PublicFoo()

    #if os(macOS)
      #if swift(>=5.0)
        XCTAssertEqual(foo.legibleDescription, "LegibleErrorTests.PublicFoo(1)")
        XCTAssertEqual(foo.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (LegibleErrorTests.PublicFoo.1)")
      #else
        XCTAssertEqual(foo.legibleDescription, "PublicFoo")
        XCTAssertEqual(foo.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (PublicFoo)")
      #endif
    #else
        //FIXME
        XCTAssertEqual(foo.legibleDescription, "PublicFoo")
        XCTAssertEqual(foo.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (PublicFoo)")
    #endif
    }

    func test_internal_Swift_class() {
        let foo = InternalFoo()

    #if os(macOS)
      #if swift(>=5.0)
        XCTAssertEqual(foo.legibleDescription, "LegibleErrorTests.InternalFoo(1)")
        XCTAssertEqual(foo.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (LegibleErrorTests.InternalFoo.1)")
      #else
        XCTAssertEqual(foo.legibleDescription, "InternalFoo")
        XCTAssertEqual(foo.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (InternalFoo)")
      #endif
    #else
        XCTAssertEqual(foo.legibleDescription, "InternalFoo")
        XCTAssertEqual(foo.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (InternalFoo)")
    #endif
    }

    func test_private_Swift_class() {
        let foo = PrivateFoo()

    #if os(macOS)
      #if swift(>=5.0)
        XCTAssertEqual(foo.legibleDescription, "LegibleErrorTests.PrivateFoo(1)")
        XCTAssertEqual(foo.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (LegibleErrorTests.PrivateFoo.1)")
      #else
        XCTAssertEqual(foo.legibleDescription, "PrivateFoo")
        XCTAssertEqual(foo.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (PrivateFoo)")
      #endif
    #else
        XCTAssertEqual(foo.legibleDescription, "PrivateFoo")
        XCTAssertEqual(foo.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (PrivateFoo)")
    #endif
    }
}
