#import <Foundation/Foundation.h>
#import "src/ui/QQFarmOverlay.h"

%ctor {
    NSLog(@"[QQFarm] 插件已加载，准备拦截 WebSocket 请求...");
    
    // 在主线程初始化悬浮窗，这将触发其内部的配置加载逻辑
    dispatch_async(dispatch_get_main_queue(), ^{
        [QQFarmOverlay sharedInstance];
        NSLog(@"[QQFarm] 悬浮窗及配置已初始化");
    });
}
