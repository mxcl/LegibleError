![Masthead](../gh-pages/masthead.jpg)

## LegibleError ![badge-platforms][] ![badge-languages][] [![badge-ci][]][travis] [![badge-codecov][]][codecov] [![badge-version][]][cocoapods]

You *should* make all your `Error`s [`LocalizedError`], but this often feels
tedious; some errors are quite unlikely and you’ve already added all the context
you would need from a bug report in the associated value of the enum’s case
value.

But it’s more frustrating when an error from a third-party dependency doesn’t
implement `LocalizedError` and your bug-report contains a screenshot that says
something like this:

> The operation couldn’t be completed. (ThirdPartyModule.(unknown context at 0xx10d6b4a44).SomeError error 0.)

## Making those error messages legible

If you have an error like this:

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

The user is presented with:

> The operation couldn’t be completed. (MyModule.(unknown context at 0xx10d6b4a44).SystemError error 0.)

**Frustrating**.

So let’s use `.legibleLocalizedDescription`:

```swift
import LegibleError

let alert = UIAlertController(…)
alert.message = error.legibleLocalizedDescription
present(alert)
```

The user is presented with:

> The operation couldn’t be completed. (SystemError.databaseFailure(internalCode: 34))

Still not great, but way more useful in a bug report.

Of course if you implement `LocalizedError`, `legibleLocalizedDescription`
returns that:

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

Presents the user with:

> A serious database failure occurred. Contact support. (#34)

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

`legibleDescription` is to `description` where `legibleLocalizedDescription` is
to `localizedDescription`. `legibleDescription` is always appropriate for
communicating to *you*, the developer, which error happened. Use it in logs and
to supplement a good message for the user.

# Supporting mxcl

Hi, I’m Max Howell and I have written a lot of open source software, and
probably you already use some of it (Homebrew anyone?). I work full-time on
open source and it’s hard; currently I earn *less* than minimum wage. Please
help me continue my work, I appreciate it x

<a href="https://www.patreon.com/mxcl">
	<img src="https://c5.patreon.com/external/logo/become_a_patron_button@2x.png" width="160">
</a>

[Other donation/tipping options](http://mxcl.github.io/donate/)

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
