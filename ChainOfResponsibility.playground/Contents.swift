import UIKit

enum LoginError: Error {
  case emptyLogin
  case emptyPassword
  case wrongPassword
}

enum ServerError: Error {
  case badAddress
  case rejectedRequest
}

enum NetworkError: Error {
  case networkLost
  case timeoutError
}

func requestData(completion: @escaping (Error?) -> Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
    completion(NetworkError.timeoutError)
  })
}

protocol ErrorHandler {
  
  var next: ErrorHandler? { get set }
  
  func handleError(_ error: Error)
  
}

class LoginErrorHandler: ErrorHandler {
  
  var next: ErrorHandler?
  
  func handleError(_ error: Error) {
    guard let loginError = error as? LoginError else {
      next?.handleError(error)
      return
    }
    print(loginError)
    // Show tooltip to user
  }
  
}

class ServerErrorHandler: ErrorHandler {
  
  var next: ErrorHandler?
  
  func handleError(_ error: Error) {
    guard let serverError = error as? ServerError else {
      next?.handleError(error)
      return
    }
    print(serverError)
    // Show alert
  }
  
}

class NetworkErrorHandler: ErrorHandler {
  
  var next: ErrorHandler?
  
  func handleError(_ error: Error) {
    guard let networkError = error as? NetworkError else {
      next?.handleError(error)
      return
    }
    print(networkError)
    // Show alert
    // Try to repeat network request
  }
  
}

let loginErrorHandler = LoginErrorHandler()
let serverErrorHandler = ServerErrorHandler()
let networkErrorHandler = NetworkErrorHandler()
loginErrorHandler.next = serverErrorHandler
serverErrorHandler.next = networkErrorHandler
networkErrorHandler.next = nil

let errorHandler: ErrorHandler = loginErrorHandler

requestData { error in
  if let error = error {
    errorHandler.handleError(error)
  }
}
