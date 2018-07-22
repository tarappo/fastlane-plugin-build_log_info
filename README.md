# build_log_info plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-build_log_info)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-build_log_info`, add it to your project by running:

```bash
fastlane add_plugin build_log_info
```

## About build_log_info

show build log information


## Fastlane Example
You need set xcpretty_formatter that is xcpretty-json-formatter.


```
# [NEED] you need set xcpretty_formatter
gym(
  xcpretty_formatter: `xcpretty-json-formatter`
)

build_log_info   
```


## Example Result

```
+--------------------------+-----+
|            Summary             |
+--------------------------+-----+
| Key                      | Num |
+--------------------------+-----+
| warnings                 | 0   |
| ld_warnings              | 0   |
| compile_warnings         | 1   |
| errors                   | 0   |
| compile_errors           | 0   |
| file_missing_errors      | 0   |
| undefined_symbols_errors | 0   |
| duplicate_symbols_errors | 0   |
| tests_failures           | 0   |
| tests_summary_messages   | 0   |
+--------------------------+-----+

+--------------------------------------+--------------------------+
|                       compile_warnings 1                        |
+--------------------------------------+--------------------------+
| FilePath                             | Reason                   |
+--------------------------------------+--------------------------+
| /YourPath/ViewController.swift:15:20 | string literal is unused |
+--------------------------------------+--------------------------+
```

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
