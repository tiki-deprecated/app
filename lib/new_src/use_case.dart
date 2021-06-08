/// The base UseCase
///
/// The base UseCase is the basic abstraction for all UseCases. A UseCase is the
/// basis of TIKI architecture that defines how the app will fulfill a specific
/// user's need. It uses:
/// [Presenter] to build the UI.
/// [Controller] respond to user interaction.
/// [Model] to defines its data.
/// [Repository] to communicate with the outer world.
///
/// Rather than using this abstraction to constrict the implementation of use
/// cases, the goal is to use inversion of control in the implementation to have
/// a decoupled code, based in vertical implementations
class UseCase {}