import Foundation

enum MyServiceError: Error {
    case noData
    case couldNotCreate(url: String?)
}
