@testable import LegibleError
import XCTest

public struct PublicStruct: Error {
    let a = "a"
}

struct InternalStruct: Error {
    let a = "a"
}

private struct PrivateStruct: Error {
    let a = "a"
}


class StructTest: XCTestCase {
    func test_public_Swift_struct() {
        XCTAssertEqual(PublicStruct().legibleDescription, "PublicStruct(a: \"a\")")
        XCTAssertEqual(PublicStruct().legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (PublicStruct(a: \"a\"))")
    }

    func test_internal_Swift_struct() {
        XCTAssertEqual(InternalStruct().legibleDescription, "InternalStruct(a: \"a\")")
        XCTAssertEqual(InternalStruct().legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (InternalStruct(a: \"a\"))")
    }

    func test_private_Swift_enum() {
        XCTAssertEqual(PrivateStruct().legibleDescription, "PrivateStruct(a: \"a\")")
        XCTAssertEqual(PrivateStruct().legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (PrivateStruct(a: \"a\"))")
    }

    func test_local_Swift_struct() {
        struct Struct: Error {
            let a = "a"
        }

        XCTAssertEqual(Struct().legibleDescription, "Struct(a: \"a\")")
        XCTAssertEqual(Struct().legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (Struct(a: \"a\"))")
    }

    func test_Swift_LocalizedError_struct_without_errorDescription() {
        struct Foo: LocalizedError {
            let a = "a"
        }

        XCTAssertEqual(Foo().legibleDescription, "Foo(a: \"a\")")
        XCTAssertEqual(Foo().legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (Foo(a: \"a\"))")
    }

    func test_Swift_LocalizedError_struct_with_errorDescription() {
        struct Foo: LocalizedError {
            let a = "a"

            var errorDescription: String? {
                return "Foobar"
            }
        }

        XCTAssertEqual(Foo().legibleDescription, "Foo(a: \"a\")")
        XCTAssertEqual(Foo().legibleLocalizedDescription, "Foobar")
    }
}
