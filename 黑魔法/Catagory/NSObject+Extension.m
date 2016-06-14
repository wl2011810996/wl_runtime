//
//  NSObject+Extension.m
//  黑魔法
//
//  Created by wleleven on 16/6/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/message.h>

@implementation NSObject (Extension)

+(void)swizzleClassMethod:(Class)class originSeletor:(SEL)method otherSelector:(SEL)othermethod
{
    Method otherMethod = class_getInstanceMethod(class,method);
    Method originMethod = class_getInstanceMethod(class, othermethod);
    method_exchangeImplementations(originMethod, otherMethod);
}

@end


@implementation NSArray (Extension)

-(id)wl_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self wl_objectAtIndex:index];
    }else
    {
        return nil;
    }
}

+(void)load
{
    [self swizzleClassMethod:NSClassFromString(@"__NSArrayI") originSeletor:@selector(wl_objectAtIndex:) otherSelector:@selector(objectAtIndex:)];
}

@end

@implementation NSMutableArray (Extension)

+(void)load
{
    [self swizzleClassMethod:NSClassFromString(@"__NSArrayM") originSeletor:@selector(wl_addobject:) otherSelector:@selector(addObject:)];
}

-(void)wl_addobject:(id)object
{
    if (object != nil) {
        [self wl_addobject:object];
    }
}

@end