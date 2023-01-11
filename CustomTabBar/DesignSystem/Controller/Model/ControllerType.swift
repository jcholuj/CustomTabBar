import Foundation

enum ControllerType: Equatable {
  case selectable
  case segmentable(SegmentType)
}

extension ControllerType {
  var horizontalPadding: CGFloat {
    switch self {
    case .selectable:
      return Constants.horizontalSmallPadding
    case let .segmentable(segmentType):
      return segmentType == .two
      ? Constants.horizontalPadding
      : Constants.horizontalSmallPadding
    }
  }
  
  var hasIcon: Bool {
    guard case let .segmentable(segmentType) = self else {
      return false
    }
    return segmentType == .two
  }
  
  var isSegmentedControl: Bool {
    self != .selectable
  }
  
  var itemsCount: Int {
    switch self {
    case let .segmentable(segmentType):
      return segmentType == .two ? 2 : 3
    default:
      return 0
    }
  }
}

private extension ControllerType {
  enum Constants {
    static let horizontalPadding: CGFloat = 14
    static let horizontalSmallPadding: CGFloat = 8
  }
}

enum SegmentType {
  case two
  case three
}
