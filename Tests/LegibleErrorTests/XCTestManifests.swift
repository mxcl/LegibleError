import XCTest

extension Test {
    static let __allTests = [
        ("test_CocoaError", test_CocoaError),
        ("test_derived_annotated_NSError", test_derived_annotated_NSError),
        ("test_derived_NSError", test_derived_NSError),
        ("test_derived_underlying_NSError", test_derived_underlying_NSError),
        ("test_simple_Swift_enum", test_simple_Swift_enum),
        ("test_Swift_class", test_Swift_class),
        ("test_Swift_LocalizedError_class_with_errorDescription", test_Swift_LocalizedError_class_with_errorDescription),
        ("test_Swift_LocalizedError_class_without_errorDescription", test_Swift_LocalizedError_class_without_errorDescription),
        ("test_Swift_LocalizedError_enum_with_errorDescription", test_Swift_LocalizedError_enum_with_errorDescription),
        ("test_Swift_LocalizedError_enum_without_errorDescription", test_Swift_LocalizedError_enum_without_errorDescription),
        ("test_Swift_LocalizedError_struct_with_errorDescription", test_Swift_LocalizedError_struct_with_errorDescription),
        ("test_Swift_LocalizedError_struct_without_errorDescription", test_Swift_LocalizedError_struct_without_errorDescription),
        ("test_Swift_struct", test_Swift_struct),
        ("test_vanilla_NSError", test_vanilla_NSError),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Test.__allTests),
    ]
}
#endif
