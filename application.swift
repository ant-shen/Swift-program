// Programmer: Kevin Kim & Anthony Shen
// Instructor: Professor Raheja
// Course: CS 4080-03
// Date: 14 November 2023
// Description: This is our Swift application program that performs matrix operations.

// NOTE: importing "Foundation" will import namespaces that contain a set of predefined 
//       symbols or functions.
import Foundation

var matrix1: [[Float]] = []
var matrix2: [[Float]] = []

// this driver program tests three different operations with matrices.
func main() {
    var userInput = 0
    // prompt the user to enter the size for the first matrix.
    print("Please enter the size for the Matrix #1:")
    print("Number of rows: ", terminator: "")
    // NOTE: the nil-coalescing operator (??) will ensure that we have a non-nil string.
    guard let row = Int(readLine() ?? "") else {
        print("Invalid input. Please enter a valid number of rows.")
        return
    }
    print("Number of columns: ", terminator: "")
    guard let col = Int(readLine() ?? "") else {
        print("Invalid input. Please enter a valid number of columns.")
        return
    }
    // create the first matrix using the row and the column values.
    matrix1 = Array(repeating: Array(repeating: 0, count: col), count: row)

    // prompt the user to enter the size for the second matrix.
    print("Please enter the size for Matrix #2:")
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
    // create the second matrix using the row and the column values.
    matrix2 = Array(repeating: Array(repeating: 0, count: col), count: row)
    
    // prompt the user to enter the elements for two matrices.
    print("Enter values for Matrix #1:")
    matrix1 = readMatrix()
    print("Enter values for Matrix #2:")
    matrix2 = readMatrix()
    
    // display the two matrices before any operation is performed..
    print("\nMatrix #1:")
    printMatrices(matrix: matrix1)
    print("Matrix #2:")
    printMatrices(matrix: matrix2)
    
    // present a menu that allows the user to select the operation they want to test.
    repeat {
        print("\nPlease select from the following options:")
        print("(1) Add the matrices.")
        print("(2) Subtract the matrices.")
        print("(3) Multiply the matrices.")
        print("(4) Select two new matrices.")
        print("(5) Exit the program.")
        
        if let input = readLine(), let choice = Int(input) 
        {
            userInput = choice

            // NOTE: Swift does NOT require parentheses around an entire expression for
            //       a switch statement unlike C, C++, and Java.
            switch userInput 
            {
            case 1:
                // check to see if addition is permissible on the two matrices.
                if !checkAdditionPermissibility(matrix1: matrix1, matrix2: matrix2) {
                    print("Error: Addition is not permissible on the current matrices. Please enter two new matrices to perform addition.")
                } else {
                    // perform addition on two matrices and print out the result.
                    print("Result of addition:")
                    printMatrices(matrix: addition(matrix1: matrix1, matrix2: matrix2))
                    // NOTE: "break" statement is unnecessary since Swift does not allow automatic
                    //       fall through in the bottom of each case for switch statements. 
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
                    printMatrices(matrix: multiplication(matrix1: matrix1, matrix2: matrix2))
                }
            case 4:
                // prompt the user to enter the size for the first matrix.
                print("Please enter the size for the Matrix #1:")
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
                // create the first matrix using the row and the column values.
                matrix1 = Array(repeating: Array(repeating: 0, count: col), count: row)

                // prompt the user to enter the size for the second matrix.
                print("Please enter the size for Matrix #2:")
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
                // create the second matrix using the row and the column values.
                matrix2 = Array(repeating: Array(repeating: 0, count: col), count: row)
    
                print("Enter values for Matrix #1:")
                matrix1 = readMatrix()
                print("Enter values for Matrix #2:")
                matrix2 = readMatrix()
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

// this function allows the user to enter the elements for a matrix row by row.
func readMatrix() -> [[Float]] 
{
    var matrix: [[Float]] = []
    for i in 0..<matrix1.count {
        print("Row \(i + 1):")
        if let input = readLine() {
            // split the input line into an array of substrings using a space as the separator,
            // and convert each substring to a Float.
            // NOTE: $0 represents each element/substring produced by the split function.
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

// this function will print out the matrix row by row.
func printMatrices(matrix: [[Float]]) {
    for row in matrix {
        // convert each Float element in the row array to a String, then print them to the console.
        print(row.map { String($0) }.joined(separator: " "))
    }
    print()
}

 // this function performs matrix addition.
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

 // this function performs matrix subtraction.
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

 // this function performs matrix multiplication.
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

// NOTE: The main() function needs to be called explicitly in Swift unlike Java,
//       C, and C++, which uses the main() method as the single entry point where 
//       the compiler starts program execution.
main()