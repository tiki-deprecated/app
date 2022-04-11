
# TIKI App
The TIKI app is the tool for user data ownership.

With TIKI App the users can have insights of who is using their data, manage the access to it, collect their own data, anonymize and sell it (or do whatever they want!).

[Why is TIKI open source?](https://blog.mytiki.com/p/real-transparency-is-powerfu)

## How to Install

TIKI app is built with [Flutter](https://flutter.dev).

1. [Install Flutter](https://docs.flutter.dev/get-started/install)
2. Clone this repository.
3. Configure Firebase account
4. Go to app's root directory.
5. Get pub dependencies - `flutter pub get`.
6. Run the app  
   -- production mode: `flutter run`.  
   -- development mode: `flutter run --dart-define=com.mytiki.app.environment=develop`

## Code structure

In TIKI we use the [vertical slice architecture](https://jimmybogard.com/vertical-slice-architecture/) to organize the code.

Each feature is developed in a [Flutter Package or Plugin](https://docs.flutter.dev/development/packages-and-plugins/using-packages) in its own repository.

The app code is responsible for initializing the Home Screen, the packages and plugins with the other features, and to implement the Data Slice.


Currently TIKI App is made with the following libs.  
| Library | Description|  
|--|--|  
| [login](https://github.com/tiki/login) | Handles user login flow and user keys management.  
| [money](https://github.com/tiki/money) | Manages the "money" screen.  
| [decision](https://github.com/tiki/decision) | Manages the "decision" screen.  
| [user_account](https://github.com/tiki/user_account) | User account menu bottom sheet UI.  
|  
| [spam_cards](https://github.com/tiki/spam_cards) | TIKI Spam Cards UI.  
| [info_carousel](https://github.com/tiki/info_carousel) | TIKI info cards UI.  
|  
| [tiki_kv](https://github.com/tiki/tiki_kv) | Simple encrypted database Key-value storage.  
| [style](https://github.com/tiki/style) | TIKI Style library.  
|  
| [httpp](https://github.com/tiki/httpp) | HTTP Parallel requests handling with Dart.  
| [microsoft_provider](https://github.com/tiki/microsoft_provider) | API for Microsoft (Outlook) data fetching.  
| [google_provider](https://github.com/tiki/google_provider) | API for Google (Gmail)  data fetching.  
|  
| [localchain](https://github.com/tiki/localchain) | TIKI's localized mobile blockchain (dart native).  
| [syncchain](https://github.com/tiki/syncchain) | Mobile side implementation of TIKI's sync chain for backing up local chains.  
| [wallet](https://github.com/tiki/wallet) | Very simple wallet for managing crypto keys.  
| [localgraph](https://github.com/tiki/localgraph) | Mobile side implementation of Knowledge Graph Service.  
|   
| [zendesk_flutter](https://github.com/tiki/zendesk_flutter) | TIKI Zendesk Help Center inside the app.  
| [upvoty](https://github.com/tiki/upvoty) | In-app user feedback.

## How to contribute
Thank you for contributing with the data revolution!  
All the information about contribution can be found in [CONTRIBUTING](https://github.com/tiki/app/CONTRIBUTING.md)