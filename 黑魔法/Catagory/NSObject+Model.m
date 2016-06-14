//
//  NSObject+Model.m
//  黑魔法
//
//  Created by wleleven on 16/6/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/message.h>
/*
 Ivar ivar1;
 Ivar ivar2;
 Ivar ivar3;
 Ivar a[] = {ivar3,ivar1,ivar2};
 Ivar *ivar = &a;
 
 */


@implementation NSObject (Model)

 
+ (instancetype)modelWithDict:(NSDictionary *)dict{
    
    // 创建对应类的对象
    id objc = [[self alloc]init];
    
    // runtime:遍历模型中所有成员属性,去字典中查找
    // 属性定义在哪,定义在类,类里面有个属性列表(数组)
    
    // 遍历模型所有成员属性
    // ivar:成员属性
    // class_copyIvarList:把成员属性列表复制一份给你
    // Ivar *:指向Ivar指针
    // Ivar *:指向一个成员变量数组
    // class:获取哪个类的成员属性列表
    // count:成员属性总数
    
    unsigned int count = 0;
    
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivarList[i];
        
        NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        NSString *propertyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        NSString *key = [propertyName substringFromIndex:1];
        
//        NSLog(@"%@",propertyName);
        NSLog(@"%@",propertyType);
        //_reposts_count
//        NSLog(@"%@",dict);
        
        // 二级转换
        // 值是字典,成员属性的类型不是字典,才需要转换成模型
        id value = dict[key];
        
        if ([value isKindOfClass:[NSDictionary class]]&&![propertyType containsString:@"NS"]) {
            //转换成那个类型
            
//            NSLog(@"%@",propertyType);
            // @"@\"User\"" User
            NSRange range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringFromIndex:range.location + range.length];
            
//              NSLog(@"%@",propertyType);
            // User\"";
            range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringToIndex:range.location];
            
//            NSLog(@"%@",propertyType);
//            NSLog(@"aaa");
        
            // 字符串截取
            
            // 获取需要转换类的类对象
            
            Class modelClass =  NSClassFromString(propertyType);
            
            if (modelClass) {
                value =  [modelClass modelWithDict:value];
                
            }
            NSLog(@"%@",value);
            
        }
        

        if (value) {
            
            // KVC赋值:不能传空

            [objc setValue:value forKey:key];
        }
        
    }
    
    
    return objc;
}
@end
