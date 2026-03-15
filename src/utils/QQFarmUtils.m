#import "QQFarmUtils.h"
#import <UIKit/UIKit.h>

static NSString *gLastCapturedCode = nil;

@implementation QQFarmUtils

+ (void)checkAndExtractCode:(NSURL *)url {
    if (!url) return;
    
    NSString *urlString = url.absoluteString;
    // 检查是否匹配目标域名和路径
    if ([urlString containsString:@"gate-obt.nqf.qq.com/prod/ws"]) {
        NSLog(@"[QQFarm] 🎯 捕获到目标 WebSocket URL: %@", urlString);
        
        NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
        NSArray<NSURLQueryItem *> *queryItems = components.queryItems;
        
        for (NSURLQueryItem *item in queryItems) {
            if ([item.name isEqualToString:@"code"]) {
                NSString *code = item.value;
                if (code && code.length > 0) {
                    NSLog(@"[QQFarm] ✅ 成功提取 Code: %@", code);
                    
                    // 保存 Code
                    gLastCapturedCode = [code copy];
                    
                    // 发送通知
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [UIPasteboard generalPasteboard].string = code;
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"kQQFarmCodeCapturedNotification" object:nil userInfo:@{@"code": code}];
                    });
                }
                break;
            }
        }
    }
}

+ (NSString *)getLastCapturedCode {
    return gLastCapturedCode;
}

@end
