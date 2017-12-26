//
//  LogBook.m
//  test
//
//  Created by Admin on 2017/12/13.
//  Copyright © 2017年 xiaowei. All rights reserved.
//

#import "XYSLogFormat.h"

@implementation XYSLogFormat

- (NSString * __nullable)formatLogMessage:(DDLogMessage *)logMessage NS_SWIFT_NAME(format(message:)){
    
    //取得输出时间
    NSDate *date = logMessage->_timestamp;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    
    //取得输出的内容
    NSString *content = [NSString stringWithFormat:@"%@",logMessage->_message];
    
    //取得线程id
    NSString *thredId = logMessage->_threadID;
    
    //取得文件名
    NSString *funcTionName;
    
    NSArray *parts = [logMessage->_file componentsSeparatedByString:@"/"];
    
    if ([parts count] > 0){
        
        funcTionName = [parts lastObject];
        
    }
    
    //取得方法名
    NSString *methodName = logMessage->_function;
    
    //取得行数
    NSUInteger numLine = (unsigned long)logMessage->_line;
    
    NSString *formatString = [NSString stringWithFormat:@"%@ %@[%@] %@ %@ %lu\n\n",currentDateString,content,thredId,funcTionName,methodName,(unsigned long)numLine];
    
    return formatString;
    
};

@end
