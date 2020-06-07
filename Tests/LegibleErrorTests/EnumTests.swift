@testable import LegibleError
import XCTest

public enum PublicEnum: Error {
    case a
}

enum InternalEnum: Error {
    case a
}

private enum PrivateEnum: Error {
    case a
}

class EnumTests: XCTestCase {
    func test_public_Swift_enum() {
        XCTAssertEqual(PublicEnum.a.legibleDescription, "PublicEnum.a")
        XCTAssertEqual(PublicEnum.a.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (PublicEnum.a)")
    }

    func test_internal_Swift_enum() {
        XCTAssertEqual(InternalEnum.a.legibleDescription, "InternalEnum.a")
        XCTAssertEqual(InternalEnum.a.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (InternalEnum.a)")
    }

    func test_private_Swift_enum() {
        XCTAssertEqual(PrivateEnum.a.legibleDescription, "PrivateEnum.a")
        XCTAssertEqual(PrivateEnum.a.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (PrivateEnum.a)")
    }

    func test_local_Swift_enum() {
        enum Enum: Error {
            case a
        }
        XCTAssertEqual(Enum.a.legibleDescription, "Enum.a")
        XCTAssertEqual(Enum.a.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (Enum.a)")
    }

    func test_Swift_LocalizedError_enum_without_errorDescription() {
        enum Foo: LocalizedError {
            case a
        }

        XCTAssertEqual(Foo.a.legibleDescription, "Foo.a")
        XCTAssertEqual(Foo.a.legibleLocalizedDescription, "\(theOperationCouldNotBeCompleted) (Foo.a)")
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
    }
}
