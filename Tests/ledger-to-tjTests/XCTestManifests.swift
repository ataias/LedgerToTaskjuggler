import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ledger_to_tjTests.allTests),
    ]
}
#endif
