//
//  Person.h
//  黑魔法
//
//  Created by wleleven on 16/6/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>


@property (nonatomic,assign)int age;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,assign)double height;

-(void)eat;

+(void)eat;

@end
