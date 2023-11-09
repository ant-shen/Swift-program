import Foundation

var matrix1: [[Float]] = []
var matrix2: [[Float]] = []

func enterMatrices() {
    print("Enter values for Matrix #1:")
    matrix1 = readMatrix()
    
    print("Enter values for Matrix #2:")
    matrix2 = readMatrix()
}

func readMatrix() -> [[Float]] {
    var matrix: [[Float]] = []
    for i in 0..<matrix1.count {
        print("Row \(i + 1):")
        if let input = readLine() {
            let row = input.split(separator: " ").compactMap { Float($0) }
            if row.count == matrix1[0].count {
                matrix.append(row)
            } else {
                print("Invalid number of elements. Please enter \(matrix1[0].count) floating point values separated by space.")
                return readMatrix()
            }
        } else {
            print("Invalid input. Please enter floating point values separated by space.")
            return readMatrix()
        }
    }
    return matrix
}

func printMatrices(matrix: [[Float]]) {
    for row in matrix {
        print(row.map { String($0) }.joined(separator: " "))
    }
    print()
}

func addition(matrix1: [[Float]], matrix2: [[Float]]) -> [[Float]] {
    let row = matrix1.count
    let col = matrix1[0].count
    var result: [[Float]] = Array(repeating: Array(repeating: 0, count: col), count: row)
    
    for i in 0..<row {
        for j in 0..<col {
            result[i][j] = matrix1[i][j] + matrix2[i][j]
        }
    }
    return result
}

func subtraction(matrix1: [[Float]], matrix2: [[Float]]) -> [[Float]] {
    let row = matrix1.count
    let col = matrix1[0].count
    var result: [[Float]] = Array(repeating: Array(repeating: 0, count: col), count: row)
    
    for i in 0..<row {
        for j in 0..<col {
            result[i][j] = matrix1[i][j] - matrix2[i][j]
        }
    }
    return result
}

func multiplication(matrix1: [[Float]], matrix2: [[Float]]) -> [[Float]] {
    let row = matrix1.count
    let col = matrix2[0].count
    let row2 = matrix2.count
    var result: [[Float]] = Array(repeating: Array(repeating: 0, count: col), count: row)
    
    for i in 0..<row {
        for j in 0..<col {
            for k in 0..<row2 {
                result[i][j] += matrix1[i][k] * matrix2[k][j]
            }
        }
    }
    return result
}

func checkAdditionPermissibility(matrix1: [[Float]], matrix2: [[Float]]) -> Bool {
    return matrix1.count == matrix2.count && matrix1[0].count == matrix2[0].count
}

func checkMultiplicationPermissibility(matrix1: [[Float]], matrix2: [[Float]]) -> Bool {
    return matrix1[0].count == matrix2.count
}

func main() {
    var userInput = 0
    
    print("Please enter the size of the matrices:")
    print("Number of rows: ", terminator: "")
    guard let row = Int(readLine() ?? "") else {
        print("Invalid input. Please enter a valid number of rows.")
        return
    }
    print("Number of columns: ", terminator: "")
    guard let col = Int(readLine() ?? "") else {
        print("Invalid input. Please enter a valid number of columns.")
        return
    }
    
    matrix1 = Array(repeating: Array(repeating: 0, count: col), count: row)
    matrix2 = Array(repeating: Array(repeating: 0, count: col), count: row)
    
    enterMatrices()
    
    print("Matrix #1:")
    printMatrices(matrix: matrix1)
    print("Matrix #2:")
    printMatrices(matrix: matrix2)
    
    repeat {
        print("\nPlease select from the following options:")
        print("(1) Add the matrices.")
        print("(2) Subtract the matrices.")
        print("(3) Multiply the matrices.")
        print("(4) Select two new matrices.")
        print("(5) Exit the program.")
        
        if let input = readLine(), let choice = Int(input) {
            userInput = choice
            switch userInput {
            case 1:
                if !checkAdditionPermissibility(matrix1: matrix1, matrix2: matrix2) {
                    print("Error: Addition is not permissible on the current matrices. Please enter two new matrices to perform addition.")
                } else {
                    print("Result of addition:")
                    printMatrices(matrix: addition(matrix1: matrix1, matrix2: matrix2))
                }
            case 2:
                if !checkAdditionPermissibility(matrix1: matrix1, matrix2: matrix2) {
                    print("Error: Subtraction is not permissible on the current matrices. Please enter two new matrices to perform subtraction.")
                } else {
                    print("Result of subtraction:")
                    printMatrices(matrix: subtraction(matrix1: matrix1, matrix2: matrix2))
                }
            case 3:
                if !checkMultiplicationPermissibility(matrix1: matrix1, matrix2: matrix2) {
                    print("Error: Multiplication is not permissible on the current matrices. Please enter two new matrices to perform multiplication.")
                } else {
                    print("Result of multiplication:")
                    let start = DispatchTime.now()
                    let result = multiplication(matrix1: matrix1, matrix2: matrix2)
                    printMatrices(matrix: result)
                    let end = DispatchTime.now()
                    let timeInterval = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000
                    print("Matrix Multiplication finished performing in \(timeInterval) seconds.")
                }
            case 4:
                print("Please enter the size of the new matrices:")
                print("Number of rows: ", terminator: "")
                guard let newRow = Int(readLine() ?? "") else {
                    print("Invalid input. Please enter a valid number of rows.")
                    continue
                }
                print("Number of columns: ", terminator: "")
                guard let newCol = Int(readLine() ?? "") else {
                    print("Invalid input. Please enter a valid number of columns.")
                    continue
                }
                matrix1 = Array(repeating: Array(repeating: 0, count: newCol), count: newRow)
                matrix2 = Array(repeating: Array(repeating: 0, count: newCol), count: newRow)
                enterMatrices()
           case 5:
                print("Terminating the program... Good bye!")
            default:
                print("Please enter a number from 1 to 5.")
            }
        } else {
            print("Invalid input. Please enter a valid menu option.")
        }
    } while userInput != 5
}

main()