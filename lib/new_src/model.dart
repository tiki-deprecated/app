/// The base Model
///
/// The base Model is the basic abstraction for all Models. A Model is the
/// basic data structure that defines what is the data used by a [UseCase].
///
/// Rather than using this abstraction to constrict the implementation of
/// models, the goal is to use inversion of control in the implementation
/// to have a decoupled code, based in vertical implementations.
class Model {}
