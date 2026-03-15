#import <Foundation/Foundation.h>

/**
 * 工具类：QQFarmUtils
 * 提供 URL 检查和 code 提取功能
 */
@interface QQFarmUtils : NSObject

/**
 * 检查 URL 并提取 code 参数
 * @param url 需要检查的 URL 对象
 */
+ (void)checkAndExtractCode:(NSURL *)url;

/**
 * 获取最后一次捕获到的 Code
 * @return 捕获到的 Code，如果没有则返回 nil
 */
+ (NSString *)getLastCapturedCode;

@end
