//
//  XYSLogManager.h
//  test
//
//  Created by Admin on 2017/12/14.
//  Copyright © 2017年 xiaowei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYSLogFormat.h"

//错误信息
#define XYSLogError(format,...)    DDLogError(format,##__VA_ARGS__)
//警告信息
#define XYSLogWarn(format,...)     DDLogWarn(format,##__VA_ARGS__)
//描述信息
#define XYSLogInfo(format,...)     DDLogInfo(format,##__VA_ARGS__)
//调试信息
#define XYSLogDebug(format,...)    DDLogDebug(format,##__VA_ARGS__)
//详细信息
#define XYSLogVerbose(format,...)  DDLogVerbose(format,##__VA_ARGS__)

//输出的层级
#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelOff;
#endif

@interface XYSLogManager : NSObject

//log保存地址
@property (nonatomic ,copy) NSString *logoSaveAddress;

//单例
+ (XYSLogManager *)share;
// 外部调用将产生编译错误
+(instancetype) alloc __attribute__((unavailable("alloc not available, call share instead")));
-(instancetype) init __attribute__((unavailable("init not available, call share instead")));
+(instancetype) new __attribute__((unavailable("new not available, call share instead")));
//将log写入本地文件
- (void)addSaveFileWithSaveAddress:(NSString *)saveAddress;

@end
