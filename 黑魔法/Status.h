//
//  Status.h
//  黑魔法
//
//  Created by wleleven on 16/6/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface Status : NSObject

// 写一段程序自动生成属性代码
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSString *source;

@property (nonatomic, assign) int reposts_count;

@property (nonatomic, strong) NSArray *pic_urls;

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, assign) int attitudes_count;

@property (nonatomic, strong) NSString *idstr;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, assign) int comments_count;

@property (nonatomic, strong) User *user;

@property (nonatomic, strong) NSDictionary *retweeted_status;

+ (Status *)statusWithDict:(NSDictionary *)dict;

@end
