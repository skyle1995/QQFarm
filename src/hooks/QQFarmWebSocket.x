#import <Foundation/Foundation.h>
#import "../utils/QQFarmUtils.h"

// 声明 SRWebSocket 接口以避免编译警告
@interface SRWebSocket : NSObject
- (id)initWithURLRequest:(NSURLRequest *)request;
- (id)initWithURL:(NSURL *)url;
@end

// 钩子：SRWebSocket (常用于第三方库和小程序容器)
%hook SRWebSocket

/**
 * 拦截 initWithURLRequest 初始化方法
 */
- (id)initWithURLRequest:(NSURLRequest *)request {
    if (request && request.URL) {
        [QQFarmUtils checkAndExtractCode:request.URL];
    }
    return %orig;
}

/**
 * 拦截 initWithURL 初始化方法
 */
- (id)initWithURL:(NSURL *)url {
    [QQFarmUtils checkAndExtractCode:url];
    return %orig;
}

%end

// 钩子：NSURLSession (iOS 原生 WebSocket 实现)
%hook NSURLSession

/**
 * 拦截 webSocketTaskWithURL
 */
- (NSURLSessionWebSocketTask *)webSocketTaskWithURL:(NSURL *)url {
    [QQFarmUtils checkAndExtractCode:url];
    return %orig;
}

/**
 * 拦截 webSocketTaskWithURL:protocols:
 */
- (NSURLSessionWebSocketTask *)webSocketTaskWithURL:(NSURL *)url protocols:(NSArray<NSString *> *)protocols {
    [QQFarmUtils checkAndExtractCode:url];
    return %orig;
}

/**
 * 拦截 webSocketTaskWithRequest
 */
- (NSURLSessionWebSocketTask *)webSocketTaskWithRequest:(NSURLRequest *)request {
    if (request && request.URL) {
        [QQFarmUtils checkAndExtractCode:request.URL];
    }
    return %orig;
}

%end
