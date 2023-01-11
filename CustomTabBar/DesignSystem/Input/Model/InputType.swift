import Foundation

enum InputType {
  case surname
  case nip
  case taxOffice
  case password
}

extension InputType {
  var title: String {
    switch self {
    case .surname:
      return "Nazwisko"
    case .nip:
      return "NIP"
    case .taxOffice:
      return "Urząd Skarbowy"
    case .password:
      return "Hasło"
    }
  }
  
  var placeholder: String {
    switch self {
    case .surname:
      return "Nazwisko (opcjonalnie)"
    case .nip:
      return "Wprowadź swój NIP"
    case .taxOffice:
      return "Wyszukaj Urząd"
    case .password:
      return "Wpisz hasło"
    }
  }
  
  var validationMessage: String {
    "Wpisz prawidłowe dane"
  }
  
  var hasTooltip: Bool {
    switch self {
    case .nip, .taxOffice, .password:
      return true
    default:
      return false
    }
  }
  
  var isSearchField: Bool {
    switch self {
    case .taxOffice:
      return true
    default:
      return false
    }
  }
}
