import XCTest
@testable import CountOnMe

class CalculationTests: XCTestCase {

    var calculation: Calculation!

    override func setUp() {
        super.setUp()
        calculation = Calculation()
    }

    func testGivenOperationIsOnePlusOne_WhenEqualIsTapped_ThenTotalIsFour() {
        calculation.addNumber(1)
        _ = calculation.addOperator(.plus)
        calculation.addNumber(1)

        _ = calculation.evaluate()

        XCTAssertEqual(calculation.total, 2)
    }

    func testGivenNoOperationIsEntered_WhenOperatorIsTapped_ThenAddingOperatorFails() {
        let success = calculation.addOperator(.plus)

        XCTAssertFalse(success)
    }

    func testGivenNoOperationIsEntered_WhenDeleteIsTapped_ThenErrorIsProduced() {
        let success = calculation.delete()

        XCTAssertFalse(success)
    }

    func testGivenNumberIs40_WhenDeleteIsTapped_ThenNumberIs4() {
        calculation.addNumber(40)

        _ = calculation.delete()

        XCTAssertEqual(calculation.numbers[calculation.numbers.count-1], "4")
    }

    func testGivenOperationIsOnePlus_WhenDeleteIsTapped_ThenOperationIs1AndOperatorIsDeleted() {
        calculation.addNumber(1)
        _ = calculation.addOperator(.plus)

        _ = calculation.delete()

        XCTAssertEqual(calculation.numbers[calculation.numbers.count-1], "1")
        XCTAssertEqual(calculation.operators.count, 1)
    }

    func testGivenOperationIsOnePlusOne_WhenClearIsTapped_ThenOperatorsAndNumbersAreReset() {
        calculation.addNumber(1)
        _ = calculation.addOperator(.plus)
        calculation.addNumber(1)

        calculation.clear()

        XCTAssertEqual(calculation.operators.count, 1)
        XCTAssertEqual(calculation.numbers.count, 1)
        XCTAssertEqual(calculation.displayString, "")
    }
}
