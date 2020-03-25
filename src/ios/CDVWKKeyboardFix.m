/*! Copyright 2018 Ayogo Health Inc. */

#import <objc/runtime.h>
#import <WebKit/WebKit.h>
#import "CDVWKKeyboardFix.h"

#define UNWRAP_BASE64(str) [[NSString alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:str options:0] encoding:NSUTF8StringEncoding]

@implementation WKWebView (CDVWKKeyboardFix)
+ (void)load {
    if (@available(iOS 13.4, *)) {
        // Fixed on iOS >= 13.4
    } else if (@available(iOS 12.0, *)) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class class = [self class];

            // _keyboardChangedWithInfo:adjustScrollView:
            SEL originalSelector = NSSelectorFromString(UNWRAP_BASE64(@"X2tleWJvYXJkQ2hhbmdlZFdpdGhJbmZvOmFkanVzdFNjcm9sbFZpZXc6"));
            // _cdv_keyboardChangedWithInfo:adjustScrollView:
            SEL swizzledSelector = NSSelectorFromString(UNWRAP_BASE64(@"X2Nkdl9rZXlib2FyZENoYW5nZWRXaXRoSW5mbzphZGp1c3RTY3JvbGxWaWV3Og=="));

            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

            BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));

            if (didAddMethod) {
                class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        });
    }
}

#pragma mark - Method Swizzling
- (void)_cdv_keyboardChangedWithInfo:(NSDictionary *)keyboardInfo adjustScrollView:(BOOL)adjustScrollView API_AVAILABLE(ios(12))
{
    /* What we *want* is this line of code here (in the WKScrollView):

     _keyboardBottomInsetAdjustment = [[UIPeripheralHost sharedInstance] getVerticalOverlapForView:self usingKeyboardInfo:info];

     */

    // UIPeripheralHost
    Class uiph = NSClassFromString(UNWRAP_BASE64(@"VUlQZXJpcGhlcmFsSG9zdA=="));
    // sharedInstance
    id si = [uiph valueForKey:UNWRAP_BASE64(@"c2hhcmVkSW5zdGFuY2U=")];
    // getVerticalOverlapForView:usingKeyboardInfo:
    SEL sel_gvofv = NSSelectorFromString(UNWRAP_BASE64(@"Z2V0VmVydGljYWxPdmVybGFwRm9yVmlldzp1c2luZ0tleWJvYXJkSW5mbzo="));

    double(*gvofv)(id, SEL, id, id) = (double(*)(id, SEL, id, id))[si methodForSelector:sel_gvofv];

    double overlap = gvofv(si, sel_gvofv, [self scrollView], keyboardInfo);

    // _keyboardBottomInsetAdjustment
    [[self scrollView] setValue:@(overlap) forKey:UNWRAP_BASE64(@"X2tleWJvYXJkQm90dG9tSW5zZXRBZGp1c3RtZW50")];

    [self _cdv_keyboardChangedWithInfo:keyboardInfo adjustScrollView:adjustScrollView];
}
@end



@implementation CDVWKKeyboardFix
- (void) pluginInitialize
{
    NSLog(@"Initializing WKWebView Keyboard Fix");
}
@end
