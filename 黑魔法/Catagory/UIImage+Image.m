//
//  UIImage+Image.m
//  黑魔法
//
//  Created by wleleven on 16/6/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "UIImage+Image.h"

#import <objc/message.h>

@implementation UIImage (Image)

+(void)load
{
    // 交换方法实现,方法都是定义在类里面
    // class_getMethodImplementation:获取方法实现
    // class_getInstanceMethod:获取对象
    // class_getClassMethod:获取类方法
    // IMP:方法实现
    
    Method imageNameMethod = class_getClassMethod([UIImage class], @selector(imageNamed:));
    
    Method wl_imageNameMethod = class_getClassMethod([UIImage class], @selector(wl_imageName:));
    
    method_exchangeImplementations(imageNameMethod, wl_imageNameMethod);
}


+ (__kindof UIImage *)wl_imageName:(NSString *)imageName
{
    BOOL iOS7 = [[UIDevice currentDevice].systemVersion floatValue]>=7.0;
    UIImage *image = nil;
    if (iOS7) {
        NSString *newName = [imageName stringByAppendingString:@"_os7"];
        image = [UIImage wl_imageName:newName];
    }
    
    if (image == nil) {
        image = [UIImage wl_imageName:imageName];
    }
    return image;
}

@end
