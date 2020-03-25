<!--
  Copyright 2019 Ayogo Health Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->

cordova-plugin-WKKeyboardFix
============================

This plugin provides a temporary fix for an iOS 12 and 13 bug involving
keyboards in WKWebView causing scrolling that is not reset when the keyboard is
dismissed.

As of iOS 13.4, this bug has been fixed.

**Note:** This plugin is a **hack** around a bug in iOS. It might result in
your app being rejected from the App Store! Use this at your own risk.


Installation
------------

```
cordova plugin add cordova-plugin-wkkeyboardfix
```


Supported Platforms
-------------------

* **iOS** (cordova-ios >= 4.5.0)


Contributing
------------

Contributions of bug reports, feature requests, and pull requests are greatly
appreciated!

Please note that this project is released with a [Contributor Code of
Conduct][coc]. By participating in this project you agree to abide by its
terms.


Licence
-------

Released under the Apache 2.0 Licence.
Copyright © 2019 Ayogo Health Inc.

[coc]: https://github.com/AyogoHealth/cordova-plugin-wkkeyboardfix/blob/master/CODE_OF_CONDUCT.md
