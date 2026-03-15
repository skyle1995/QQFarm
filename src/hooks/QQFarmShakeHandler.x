#import <UIKit/UIKit.h>
#import "../ui/QQFarmOverlay.h"
#import "../utils/QQFarmUtils.h"

// Hook UIWindow to detect shake gesture
%hook UIWindow

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        // 获取最新的 code
        NSString *code = [QQFarmUtils getLastCapturedCode];
        
        // 只有当 code 存在且不为空时才显示悬浮窗
        if (code && code.length > 0) {
            // 在主线程显示悬浮窗
            dispatch_async(dispatch_get_main_queue(), ^{
                [[QQFarmOverlay sharedInstance] showWithCode:code];
            });
        }
    }
    %orig;
}

// 确保视图控制器支持摇一摇
- (BOOL)canBecomeFirstResponder {
    return YES;
}

%end
