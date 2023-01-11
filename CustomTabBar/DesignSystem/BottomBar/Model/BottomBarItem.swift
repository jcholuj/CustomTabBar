import Foundation

enum BottomBarItem: String, CaseIterable, Identifiable {
  case buttons
  case inputs
  case scanner
  case services
  case more
}

extension BottomBarItem {
  var id: String {
    rawValue
  }
  
  var title: String {
    switch self {
    case .buttons:
      return "Buttons"
    case .inputs:
      return "Inputs"
    case .scanner:
      return "Skaner QR"
    case .services:
      return "Usługi"
    case .more:
      return "Więcej"
    }
  }
  
  var icon: String {
    switch self {
    case .buttons:
      return "start"
    case .inputs:
      return "documents"
    case .scanner:
      return "scanner"
    case .services:
      return "services"
    case .more:
      return "more"
    }
  }
}

