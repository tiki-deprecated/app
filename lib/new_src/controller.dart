/// The base Controller
///
/// The base Controller is the basic abstraction for all Controllers. A
/// Controller is the responsible for receive the user interaction and pass it
/// to [UseCase] to respond.
///
/// Rather than using this abstraction to constrict the implementation of
/// controllers, the goal is to use inversion of control in the implementation
/// to have a decoupled code, based in vertical implementations.
class Controller {}
