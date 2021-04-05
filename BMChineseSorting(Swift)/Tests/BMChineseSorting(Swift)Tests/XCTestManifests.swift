import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BMChineseSorting_Swift_Tests.allTests),
    ]
}
#endif
