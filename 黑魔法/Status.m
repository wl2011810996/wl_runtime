//
//  Status.m
//  黑魔法
//
//  Created by wleleven on 16/6/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "Status.h"

@implementation Status

+ (Status *)statusWithDict:(NSDictionary *)dict
{
    Status *status = [[self alloc] init];
    
    // KVC
    [status setValuesForKeysWithDictionary:dict];
    
    return status;
}

// 解决KVC报错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _ID = [value integerValue];
    }
    // key:没有找到key
    // value:没有找到key对应的值
    NSLog(@"%@ %@",key,value);
}

@end
