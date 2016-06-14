//
//  NSObject+Objc.m
//  黑魔法
//
//  Created by wleleven on 16/6/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "NSObject+Objc.h"
#import <objc/message.h>


@implementation NSObject (Objc)

-(void)setName:(NSString *)name
{
    // 添加属性,跟对象
    // 给某个对象产生关联,添加属性
    // object:给哪个对象添加属性
    // key:属性名,根据key去获取关联的对象 ,void * == id
    // value:关联的值
    // policy:策越
    ;
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)name
{
    return objc_getAssociatedObject(self, @"name");
}

@end
