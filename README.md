![Masthead](../gh-pages/masthead.jpg)

## LegibleError ![badge-platforms][] ![badge-languages][] [![badge-ci][]][travis] [![badge-codecov][]][codecov] [![badge-version][]][cocoapods]

You *should* make all your `Error`s [`LocalizedError`], but… you don’t.

The problem is, *if* you don’t then when you try to show the error to the user
you get something obnoxious:

```swift
enum SystemError: Error {
    case databaseFailure
}

let error = SystemError.databaseFailure
// ^^ obviously you’d get this from a callback or `catch` in the real-world

let alert = UIAlertController(…)
alert.message = error.localizedDescription
present(alert)
```

Presents the user with:

> The operation couldn’t be completed. (MyModule.(unknown context at 0xx10d6b4a44).SystemError error 0.)

**BARF** 🤮

Instead use `.legibleLocalizedDescription`:

```swift
import LegibleError

let alert = UIAlertController(…)
alert.message = error.legibleLocalizedDescription
present(alert)
```

Presents the user with:

> The operation couldn’t be completed. (SystemError.databaseFailure)

Still not great, but *better* and certainly way more useful when you get bug
reports.

Of course if you implement `LocalizedError`, `legibleLocalizedDescription`
returns that:

```swift
enum SystemError: LocalizedError {
    case databaseFailure
    
    var errorDescription: String? {
        switch self {
        case databaseFailure:
            return "A serious database failure occurred. Contact support."
        }
    }
}
```

### Debuggable Error Descriptions

This:

```swift
let msg = "There was an error (\(error))"
```

Will give you this:

> There was an error (databaseFailure)

Which loses the context of the enum’s type; use `legibleDescription`:

```swift
let msg = "There was an error! \(error.legibleDescription)"
```

> There was an error (SystemError.databaseFailure)

`legibleDescription` is to `description` where `legibleLocalizedDescription is
to `localizedDescription`. `legibleDescription` is always appropriate for
communicating to *you*, the developer, which error happened. Use it in logs and
to supplement a good message for the user.

## Installation

SwiftPM:

```swift
package.append(.package(url: "https://github.com/mxcl/LegibleError.git", from: "1.0.0"))
```

CocoaPods:

```ruby
pod 'LegibleError', '~> 1.0'
```

Carthage:

> Waiting on: [@Carthage#1945].


[badge-platforms]: https://img.shields.io/badge/platforms-macOS%20%7C%20Linux%20%7C%20iOS%20%7C%20tvOS%20%7C%20watchOS-lightgrey.svg
[badge-languages]: https://img.shields.io/badge/swift-4.2%20%7C%205.0-orange.svg
[badge-codecov]: https://codecov.io/gh/mxcl/LegibleError/branch/master/graph/badge.svg
[badge-version]: https://img.shields.io/cocoapods/v/LegibleError.svg?label=version
[badge-ci]: https://travis-ci.com/mxcl/LegibleError.svg

[travis]: https://travis-ci.com/mxcl/LegibleError
[codecov]: https://codecov.io/gh/mxcl/LegibleError
[cocoapods]: https://cocoapods.org/pods/LegibleError

[`LocalizedError`]: https://developer.apple.com/documentation/foundation/localizederror
[@Carthage#1945]: https://github.com/Carthage/Carthage/pull/1945
