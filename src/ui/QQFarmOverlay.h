#import <UIKit/UIKit.h>

@interface QQFarmOverlay : UIWindow

+ (instancetype)sharedInstance;
- (void)showWithCode:(NSString *)code;
- (void)hide;

@end
