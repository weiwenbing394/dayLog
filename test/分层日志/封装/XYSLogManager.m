//
//  XYSLogManager.m
//  test
//
//  Created by Admin on 2017/12/14.
//  Copyright © 2017年 xiaowei. All rights reserved.
//

#import "XYSLogManager.h"

#define kDefaultLogSaveAddress    [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Caches/XYSLogs"]

#define kRollingFrequency         60 * 60 * 24

#define KMaximumNumberOfLogFiles  7

@interface XYSLogManager ()

@property (nonatomic ,strong) XYSLogFormat            *logFormat;

@property (nonatomic ,strong) DDTTYLogger             *logManager;

@property (nonatomic ,strong) DDLogFileManagerDefault *fileManager;

@property (nonatomic ,strong) DDFileLogger            *fileLogger;

@end

static BOOL useShareToInit = false;

@implementation XYSLogManager

//单例
+ (XYSLogManager *)share{
    
    static XYSLogManager *manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        useShareToInit = YES;
        
        manager = [[XYSLogManager alloc] init];
        
    });
    
    return manager;
};

//初始化
- (instancetype)init{
    
    if (self = [super init]) {
        
       NSAssert(useShareToInit, @"请调用单例方法 [XYSLogManager share] 进行初始化！！！");
            
       [DDLog addLogger:self.logManager];
        
    }
    
    return self;
}

//将log写入本地文件
- (void)addSaveFileWithSaveAddress:(NSString *)saveAddress{
    
    if (0==saveAddress.length||nil==saveAddress) {
        
        _logoSaveAddress = kDefaultLogSaveAddress;
        
    }else{
        
        _logoSaveAddress = saveAddress;
        
    }
    
    [DDLog addLogger:self.fileLogger];
    
};

#pragma mark 懒加载

- (XYSLogFormat *)logFormat{
    
    if (!_logFormat) {
        
        _logFormat = [[XYSLogFormat alloc] init];
        
    }
    
    return _logFormat;
    
}

- (DDTTYLogger *)logManager {
    
    if (!_logManager) {
        
        _logManager = [DDTTYLogger sharedInstance];
        
        _logManager.logFormatter = self.logFormat;
    }
    
    return _logManager;
    
}

- (DDLogFileManagerDefault *)fileManager{
    
    if (!_fileManager) {
        
        _fileManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:_logoSaveAddress];
        
    }
    
    return  _fileManager;
}

- (DDFileLogger *)fileLogger{
    
    if (!_fileLogger) {
        
        _fileLogger = [[DDFileLogger alloc] initWithLogFileManager:self.fileManager];
        
        _fileLogger.rollingFrequency = kRollingFrequency;
        
        _fileLogger.logFileManager.maximumNumberOfLogFiles = KMaximumNumberOfLogFiles;
        
        _fileLogger.logFormatter = self.logFormat;
        
    }
    
    return _fileLogger;
    
}

@end
