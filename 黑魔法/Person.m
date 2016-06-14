//
//  Person.m
//  黑魔法
//
//  Created by wleleven on 16/6/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>

@implementation Person


-(void)eat
{
    NSLog(@"调用类方法");

}

+(void)eat
{
    NSLog(@"调用对象方法");
}


void aaa (id self, SEL _cmd ,id param1)
{
    NSLog(@"调用eat %@ %@ %@",self,NSStringFromSelector(_cmd),param1);
}

+(BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(buy:)) {
        /*
         cls:给哪个类添加方法
         SEL:添加方法的方法编号是什么
         IMP:方法实现,函数入口,函数名
         types:方法类型
         */
        // @:对象 :SEL
        
        class_addMethod(self, sel, (IMP)aaa, "v@:@");
        
        return YES;
    }
   return  [super resolveInstanceMethod:sel];
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([Person class], &count);
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key =  [NSString stringWithUTF8String:name];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([Person class], &count);
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            // 设置到成员变量身上
            [self setValue:value forKey:key];
            
        }
        free(ivars);
    }
    return self;
}

/*
 - (instancetype)initWithCoder:(NSCoder *)coder
 {
 if (self = [super init]) {
 self.employeId = [coder decodeObjectForKey:@"employeId"];
 self.code = [coder decodeObjectForKey:@"code"];
 self.password = [coder decodeObjectForKey:@"password"];
 self.name = [coder decodeObjectForKey:@"name"];
 self.jobName = [coder decodeObjectForKey:@"jobName"];
 self.lastModifiedTicket = [coder decodeObjectForKey:@"lastModifiedTicket"];
 self.isRebate = [coder decodeObjectForKey:@"isRebate"];
 self.phone = [coder decodeObjectForKey:@"phone"];
 
 }
 return self;
 }
 
 - (void)encodeWithCoder:(NSCoder *)aCoder
 {
 [aCoder encodeObject:self.employeId forKey:@"employeId"];
 [aCoder encodeObject:self.code forKey:@"code"];
 [aCoder encodeObject:self.password forKey:@"password"];
 [aCoder encodeObject:self.name forKey:@"name"];
 [aCoder encodeObject:self.jobName forKey:@"jobName"];
 [aCoder encodeObject:self.lastModifiedTicket forKey:@"lastModifiedTicket"];
 [aCoder encodeObject:self.isRebate forKey:@"isRebate"];
 [aCoder encodeObject:self.phone forKey:@"phone"];
 }

 */


@end
