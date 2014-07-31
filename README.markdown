PXLActionSheet
==============

A new customizable replacement for UIActionSheet.

## Screenshots

![Screenshot](https://github.com/jasonsilberman/PXLActionSheet/blob/master/screenshot.png)

## Why?
1. The system `UIActionSheet` are very uncustomizable.
2. Blocks! Blocks! Blocks!

## Documentation
You can check out the documentation over at [Cocoadocs](http://cocoadocs.org/docsets/PXLActionSheet/).

## Adding to Your Project
Getting started using PXLNetworking is really easy! You can use Cocoapods or you can do it manually.

### Using CocoaPods
Add the following to your `Podfile`.

```ruby
pod 'PXLActionSheet'
```

### Manually
To manually add to your project:

1. Add the files in `PXLActionSheet/` to your project.

PXLNetworking requires ARC.

## Usage
PXLActionSheet is super simple.

1. Create a `PXLActionSheetTheme` (or use the defaultTheme).
2. Create and show a `PXLActionSheet`.

Here is an example:

```objc
[PXLActionSheet showInView:self.view withTheme:[PXLActionSheetTheme defaultTheme] title:@"A new customizable replacement for UIActionSheet." cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@[@"Custom Fonts", @"Custom Colors", @"And More!"] tapBlock:^(PXLActionSheet *actionSheet, NSInteger tappedButtonIndex) {
	NSLog(@"tapped at %ld", (long)tappedButtonIndex);
}];
```

*Super simple, I know!*

## License
PXLActionSheet is available under the MIT license. See the LICENSE file for more info.
