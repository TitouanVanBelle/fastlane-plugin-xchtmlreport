![screenshot](https://i.imgur.com/roUjf3N.png)

## What is it?

Fastlane plugin for XCHTMLReport

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-xchtmlreport)


## Install

- Install [XCHTMLReport](https://github.com/TitouanVanBelle/XCTestHTMLReport)
- Run
```bash
fastlane add_plugin xchtmlreport
```

## Usage

### Basic Usage

- Add the following to your Scanfile

```ruby
result_bundle(true)
```

- Add a call to `xchtmlreport` after running your tests. For example

```
lane :tests do
  scan (
  	fail_build: false # Otherwise following steps won't be executed
  )
  xchtmlreport
end
```

### Options

#### Specify the path to the result bundle

By default the plugin will use the default location of the result bundle which is under fastlane/test_output/ but your also have the ability to pass the path yourself

```ruby
xchtmlreport(
  result_bundle_path: path_to_result_bundle
)
```

You can also pass multiple paths

```ruby
xchtmlreport(
  result_bundle_paths: [
    path_to_ui_result_bundle,
    path_to_unit_result_bundle
  ]
)
```

#### Specify path to xchtmlreport

XCHTMLReport is by default install at /usr/local/bin/xchtmlreport. Should it be somewhere else you can pass the path to the binary to the plugin

```ruby
xchtmlreport(
  binary_path: path_to_xchtmlreport
)
```

### Enable JUnit reporting

You can enable the JUnit reporting as well

```ruby
xchtmlreport(
  enable_junit: true
)
```

## Contribution

Please create an issue whenever you find an issue or think a feature could be a good addition to XCTestHTMLReport's fastlane plugin. Always make sure to follow the [Contributing Guidelines](https://github.com/TitouanVanBelle/fastlane-plugin-xchtmlreport/blob/master/CONTRIBUTING.md). Feel free to take a shot at these issues.

## License

XCTestHTMLReport's fastlane plugin is [available under the MIT license](https://github.com/TitouanVanBelle/fastlane-plugin-xchtmlreport/blob/master/LICENSE).

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
