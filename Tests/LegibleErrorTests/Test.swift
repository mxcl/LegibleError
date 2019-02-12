@testable import LegibleError
import XCTest

#if swift(>=5)
let addressPattern = "0x.?+"
#else
let addressPattern = "\\$.?+"
#endif

class Test: XCTestCase {
    func test_simple_Swift_enum() {
        enum Foo: Error {
            case a
        }

        XCTAssertEqual(Foo.a.legibleDescription, "Foo.a")
        XCTAssertEqual(Foo.a.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (Foo.a)")

    #if !os(Linux)
        // tests that Swift itself hasn't improved each release
        // on Linux localizedDescription crashes: https://bugs.swift.org/browse/SR-2476
    #if swift(>=5)
        XCTAssertMatches(Foo.a.localizedDescription, "^" + theOperationCouldNotBeCompleted + #" \(LegibleErrorTests\.Test\.\(unknown context at \$.+\)\.\(unknown context at \$.+\)\.Foo error 0\.\)$"#)
    #else
        XCTAssertMatches(Foo.a.localizedDescription, "^\(theOperationCouldNotBeCompleted) \\(LegibleErrorTests\\.\\(unknown context at 0x.+\\)\\.Foo error 0\\.\\)$")
    #endif
    #endif
        XCTAssertEqual(String(describing: Foo.a), "a")
    }

    func test_Swift_struct() {
        struct Foo: Error {
            let a = "a"
        }

        XCTAssertEqual(Foo().legibleDescription, "Foo(a: \"a\")")
        XCTAssertEqual(Foo().legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (Foo(a: \"a\"))")

    #if !os(Linux)
        // tests that Swift itself hasn't improved each release
        // on Linux localizedDescription crashes: https://bugs.swift.org/browse/SR-2476
    #if swift(>=5)
        XCTAssertMatches(Foo().localizedDescription, "^" + theOperationCouldNotBeCompleted + #" \(LegibleErrorTests\.Test\.\(unknown context at \$.+\)\.\(unknown context at \$.+\)\.Foo error 1\.\)$"#)
    #else
        XCTAssertMatches(Foo().localizedDescription, "^\(theOperationCouldNotBeCompleted) \\(LegibleErrorTests\\.\\(unknown context at 0x.+\\)\\.Foo error 1\\.\\)$")
    #endif
        XCTAssertEqual(String(describing: Foo()), "Foo(a: \"a\")")
    #endif
    }

    func test_Swift_class() {
        class Foo: Error {
            let a = "a"
        }

        XCTAssertEqual(Foo().legibleDescription, "Foo")
        XCTAssertEqual(Foo().legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (Foo)")

    #if !os(Linux)
        // tests that Swift itself hasn't improved each release
        // on Linux localizedDescription crashes: https://bugs.swift.org/browse/SR-2476
    #if swift(>=5)
        XCTAssertMatches(Foo().localizedDescription, "^" + theOperationCouldNotBeCompleted + #" \(LegibleErrorTests\.Test\.\(unknown context at \$.+\)\.\(unknown context at \$.+\)\.Foo error 1\.\)$"#)
        XCTAssertMatches(String(describing: Foo()), "LegibleErrorTests\\.Test\\.\\(unknown context at \\$.+\\)\\.\\(unknown context at \\$.+\\)\\.Foo")
    #else
        XCTAssertMatches(Foo().localizedDescription, "^\(theOperationCouldNotBeCompleted) \\(LegibleErrorTests\\.\\(unknown context at 0x.+\\)\\.Foo error 1\\.\\)$")
        XCTAssertMatches(String(describing: Foo()), "LegibleErrorTests\\.\\(unknown context at 0x.+\\)\\.Foo")
    #endif
    #endif
    }

    func test_Swift_LocalizedError_enum_without_errorDescription() {
        enum Foo: LocalizedError {
            case a
        }

        XCTAssertEqual(Foo.a.legibleDescription, "Foo.a")
        XCTAssertEqual(Foo.a.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (Foo.a)")

    #if !os(Linux)
        // tests that Swift itself hasn't improved each release
        // on Linux localizedDescription crashes: https://bugs.swift.org/browse/SR-2476
    #if swift(>=5)
        XCTAssertMatches(Foo.a.localizedDescription, "^" + theOperationCouldNotBeCompleted + #" \(LegibleErrorTests\.Test\.\(unknown context at \$.+\)\.\(unknown context at \$.+\)\.Foo error 0\.\)$"#)
    #else
        XCTAssertMatches(Foo.a.localizedDescription, "^\(theOperationCouldNotBeCompleted) \\(LegibleErrorTests\\.\\(unknown context at 0x.+\\)\\.Foo error 0\\.\\)$")
    #endif
        XCTAssertEqual(String(describing: Foo.a), "a")
    #endif
    }

    func test_Swift_LocalizedError_enum_with_errorDescription() {
        enum Foo: LocalizedError {
            case a

            var errorDescription: String? {
                return "Foobar"
            }
        }

        XCTAssertEqual(Foo.a.legibleLocalizedDescription, "Foobar")
        XCTAssertEqual(Foo.a.legibleDescription, "Foo.a")

    #if !os(Linux)
        // tests that Swift itself hasn't improved each release
        // on Linux localizedDescription crashes: https://bugs.swift.org/browse/SR-2476
        XCTAssertEqual(Foo.a.localizedDescription, "Foobar")
        XCTAssertEqual(String(describing: Foo.a), "a")
    #endif
    }

    func test_Swift_LocalizedError_struct_without_errorDescription() {
        struct Foo: LocalizedError {
            let a = "a"
        }

        XCTAssertEqual(Foo().legibleDescription, "Foo(a: \"a\")")
        XCTAssertEqual(Foo().legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (Foo(a: \"a\"))")

    #if !os(Linux)
        // tests that Swift itself hasn't improved each release
        // on Linux localizedDescription crashes: https://bugs.swift.org/browse/SR-2476
    #if swift(>=5)
        XCTAssertMatches(Foo().localizedDescription, "^" + theOperationCouldNotBeCompleted + #" \(LegibleErrorTests\.Test\.\(unknown context at \$.+\)\.\(unknown context at \$.+\)\.Foo error 1\.\)$"#)
    #else
        XCTAssertMatches(Foo().localizedDescription, "^\(theOperationCouldNotBeCompleted) \\(LegibleErrorTests\\.\\(unknown context at 0x.+\\)\\.Foo error 1\\.\\)$")
    #endif
        XCTAssertEqual(String(describing: Foo()), "Foo(a: \"a\")")
    #endif
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

    #if !os(Linux)
        // tests that Swift itself hasn't improved each release
        // on Linux localizedDescription crashes: https://bugs.swift.org/browse/SR-2476
        XCTAssertEqual(Foo().localizedDescription, "Foobar")
        XCTAssertEqual(String(describing: Foo()), "Foo(a: \"a\")")
    #endif
    }

    func test_Swift_LocalizedError_class_without_errorDescription() {
        class Foo: LocalizedError {
            let a = "a"
        }

        XCTAssertEqual(Foo().legibleDescription, "Foo")
        XCTAssertEqual(Foo().legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (Foo)")

    #if !os(Linux)
        // tests that Swift itself hasn't improved each release
        // on Linux localizedDescription crashes: https://bugs.swift.org/browse/SR-2476
    #if swift(>=5)
        XCTAssertMatches(Foo().localizedDescription, "^" + theOperationCouldNotBeCompleted + #" \(LegibleErrorTests\.Test\.\(unknown context at \$.+\)\.\(unknown context at \$.+\)\.Foo error 1\.\)$"#)
        XCTAssertMatches(String(describing: Foo()), "LegibleErrorTests\\.Test\\.\\(unknown context at \\$.+\\)\\.\\(unknown context at \\$.+\\)\\.Foo")
    #else
        XCTAssertMatches(Foo().localizedDescription, "^\(theOperationCouldNotBeCompleted) \\(LegibleErrorTests\\.\\(unknown context at 0x.+\\)\\.Foo error 1\\.\\)$")
        XCTAssertMatches(String(describing: Foo()), "LegibleErrorTests\\.\\(unknown context at 0x.+\\)\\.Foo")
    #endif
    #endif
    }

    func test_Swift_LocalizedError_class_with_errorDescription() {
        class Foo: LocalizedError {
            let a = "a"

            var errorDescription: String? {
                return "Foobar"
            }
        }

        XCTAssertEqual(Foo().legibleDescription, "Foo")
        XCTAssertEqual(Foo().legibleLocalizedDescription, "Foobar")
    #if !os(Linux)
        // crashes on Linux: https://bugs.swift.org/browse/SR-2476
        XCTAssertEqual(Foo().localizedDescription, "Foobar")
    #endif
    }

    func test_vanilla_NSError() {
        let Foo = { NSError(domain: "a", code: 1) }
        XCTAssertEqual(Foo().legibleDescription, "a(1)")
        XCTAssertEqual(Foo().legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (a.1)")
    #if !os(Linux)
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
    #if !os(Linux)
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
    #if !os(Linux)
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
    #else
        XCTAssertEqual(err.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (NSCocoaErrorDomain.4866)")
        XCTAssertEqual(err.localizedDescription, theOperationCouldNotBeCompleted)
    #endif
    }
}
