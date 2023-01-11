import ComposableArchitecture
import Foundation

struct ControllerConsole: ReducerProtocol {
  var body: some ReducerProtocol<ControllerConsole.State, ControllerConsole.Action> {
    Scope(state: \.firstController, action: /ControllerConsole.Action.firstControllerAction) {
      Controller()
    }
    Scope(state: \.secondController, action: /ControllerConsole.Action.secondControllerAction) {
      Controller()
    }
    Scope(state: \.thirdController, action: /ControllerConsole.Action.thirdControllerAction) {
      Controller()
    }
    Scope(state: \.fourthController, action: /ControllerConsole.Action.fourthControllerAction) {
      Controller()
    }
    Reduce { state, action  in .none } // reduce action from Content here
  }
}

extension ControllerConsole {
  struct State: Equatable {
    var firstController: Controller.State
    var secondController: Controller.State
    var thirdController: Controller.State
    var fourthController: Controller.State
  }

  enum Action: Equatable {
    case firstControllerAction(Controller.Action)
    case secondControllerAction(Controller.Action)
    case thirdControllerAction(Controller.Action)
    case fourthControllerAction(Controller.Action)
  }
}
