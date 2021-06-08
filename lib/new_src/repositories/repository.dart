/// The base Repository
///
/// The base Repository is the basic abstraction for all Repositories. A Repository
/// is the interface between the outer world and the app. It is used by the
/// [UseCase] to access APIs, DBs, Secure Storages, Network, etc.
///
/// Rather than using this abstraction to constrict the implementation of a
/// Repository,the goal is to use inversion of control in the implementation to
/// have a decoupled code, based in vertical implementations
class Repository {}
