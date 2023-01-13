import Foundation

enum InputType {
  case search
  case text
  case secured
}

extension InputType {
  var isSearchField: Bool {
    switch self {
    case .search:
      return true
    default:
      return false
    }
  }
}
