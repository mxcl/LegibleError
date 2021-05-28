## LegibleError ![badge-platforms][] ![badge-languages][] [![badge-ci][]][gha] [![badge-codecov][]][codecov] [![badge-version][]][cocoapods]

LegibleError’s goal is to prevent you showing the user a string like this:

> The operation couldn’t be completed. (ThirdPartyModule.(unknown context at 0xx10d6b4a44).SomeError error 0.)

That string is the default `localizedDescription` for a Swift `Error`. Instead
use LegibleError and you’ll get something more like this:

> The operation couldn’t be completed. (ThirdPartyModule.SomeError.networkFailure(http: 503))

## `Error.legibleLocalizedDescription`

If you have an `Error` like this:

```swift
enum SystemError: Error {
    case databaseFailure(internalCode: Int)
}

let error = SystemError.databaseFailure
// ^^ obviously you’d get this from a callback or `catch` in the real-world

let alert = UIAlertController(…)
alert.message = error.localizedDescription
present(alert)
```

The alert will show:

> The operation couldn’t be completed. (MyModule.(unknown context at 0xx10d6b4a44).SystemError error 0.)

But if we were to use `.legibleLocalizedDescription`:

```swift
import LegibleError

let alert = UIAlertController(…)
alert.message = error.legibleLocalizedDescription
present(alert)
```

The alert will show:

> The operation couldn’t be completed. (SystemError.databaseFailure(internalCode: 34))

Still not great, but way more useful in a bug report.

If you want a great message, implement `LocalizedError` this will make both
`localizedDescription` **and** `legibleLocalizedDescription` return the string
you specify:

```swift
enum SystemError: LocalizedError {
    case databaseFailure

    var errorDescription: String? {
        switch self {
        case databaseFailure(let code):
            return "A serious database failure occurred. Contact support. (#\(code))"
        }
    }
}
```

The alert will show:

> A serious database failure occurred. Contact support. (#34)

---

LegibleError exists because:

1. You have no control over third parties and cannot force them to implement
    `LocalizedError`
2. Some Errors in your codebase are very unlikely and thus “localizing” them is
    not a good maintenance burden.
3. When logging errors you want the full information without any risk that the
    localized version has “fallen behind”, get the compiler to do the work, in
    such cases use `legibleDescription` (see the next section).

## Loggable Error Descriptions

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

> There was an error (SystemError.databaseFailure(internalCode: 34))

`legibleDescription` is to `description` where `legibleLocalizedDescription` is
to `localizedDescription`. `legibleDescription` is always appropriate for
communicating to *you*, the developer, which error happened. Use it in logs and
to supplement a good message for the user.

## Way better descriptions on Linux

Linux is a little behind, usually you only get `The operation could not be
completed` on Linux. We fully support Linux.

# Sponsorship

If you or your company depend on this project, please consider [sponsorship] so
I have justification for maintenance .

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
[badge-languages]: https://img.shields.io/badge/swift-4.2%20%7C%205.x-orange.svg
[badge-codecov]: https://codecov.io/gh/mxcl/LegibleError/branch/master/graph/badge.svg
[badge-version]: https://img.shields.io/cocoapods/v/LegibleError.svg?label=version
[badge-ci]: https://github.com/mxcl/LegibleError/workflows/Checks/badge.svg

[gha]: https://github.com/mxcl/LegibleError/actions
[codecov]: https://codecov.io/gh/mxcl/LegibleError
[cocoapods]: https://cocoapods.org/pods/LegibleError

[`LocalizedError`]: https://developer.apple.com/documentation/foundation/localizederror
[@Carthage#1945]: https://github.com/Carthage/Carthage/pull/1945
[sponsorship]: https://github.com/sponsors/mxcl
