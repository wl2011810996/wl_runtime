//
//  ViewController.m
//  黑魔法
//
//  Created by wleleven on 16/6/13.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/message.h>
#import "NSObject+Objc.h"
#import "NSObject+Property.h"
#import "Status.h"
#import "NSObject+Model.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgvOne;
@property (weak, nonatomic) IBOutlet UIImageView *imgvTwo;

@property (nonatomic,strong)NSMutableArray *names;

@property (nonatomic,strong)NSArray *books;

@end

@implementation ViewController


-(NSMutableArray *)names
{
    if (_names ==nil) {
        _names = [NSMutableArray array];
    }
    return _names;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //http://ios.jobbole.com/84672/   详情参考
    
    //runtime介绍
    [self introduceRuntime];
    
    //消息机制
    [self testOne];
    
    //交换实现方法
    [self imageSwizzle];
    
    [self testRuntimeIvar];
    
    //动态添加方法
    [self testTwo];
    
    //为分类添加属性
    [self testThree];
    
    // 自动生成属性列表
    [self testFour];
    
    //KVC字典转模型
    [self testFive];
    
    //字典转模型
    [self testSix];
}

-(void)introduceRuntime
{
    /*
     runtime运行机制：
     1.能动态产生一个类，一个成员变量，一个方法。
     2.能动态修改一个类，一个成员变量，一个方法
     3.能动态删除一个类，一个成员变量，一个方法
     
     //常见的函数，头文件
     //#import <objc/runtime.h>
     //    method_exchangeImplementations()
     //    class_getClassMethod();          获得某个集体的类方法
     //    class_getInstanceMethod();       获得某个具体的实例方法
     //    class_copyMethodList();          获得某个具体的内部的所有方法
     //    class_copyIvarList();            获得某个类内部的所有成员变量
     
     //    #import <objc/message.h>
     //    objc_msgSend();
     */
    
    /*
     
     unsigned int count;
     
     获取属性列表        objc_property_t *propertyList = class_copyPropertyList([self class], &count);
     获取方法列表        Method *methodList = class_copyMethodList([self class], &count);
     获取成员变量列表    Ivar *ivarList = class_copyIvarList([self class], &count);
     获取协议列表       __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
     */
}


-(void)testSix
{
    /*
     KVC:遍历字典中所有key,去模型中查找有没有对应的属性名
     runtime:遍历模型中所有属性名,去字典中查找
     */
    
    // 解析Plist
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *dictArr = dict[@"statuses"];
    
    NSMutableArray *statuses = [NSMutableArray array];
    // 遍历字典数组
    for (NSDictionary *dict in dictArr) {
        Status *status = [Status modelWithDict:dict];
        [statuses addObject:status];
    }
    
    NSLog(@"%@",statuses);
}


-(void)testFive
{
    // 解析Plist
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"wl_status.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *dictArr = dict[@"statuses"];
    
    // 设计模型属性代码
    //    [NSObject createPropertyCodeWithDict:dictArr[0]];
    NSMutableArray *statuses = [NSMutableArray array];
    
    for (NSDictionary *dict in dictArr) {
        // 字典转模型
        Status *status = [Status statusWithDict:dict];
        
        [statuses addObject:status];
        
    }
    
    NSLog(@"%@",statuses);
}

-(void)testFour
{
    // 解析Plist
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"status.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *dictArr = dict[@"statuses"];
    
    // 设计模型属性代码
    [NSObject createPropertyCodeWithDict:dictArr[0]];
    
    for (NSDictionary *dict in dictArr) {
        //字典转模型
    }
}

-(void)testThree
{
    NSObject *objc = [[NSObject alloc]init];
    objc.name = @"123";
    NSLog(@"%@",objc.name);
    
}

-(void)testTwo
{
    Person *p = [[Person alloc]init];
    
//  [p performSelector:@selector(buy)];
    [p performSelector:@selector(buy:) withObject:@111];
}

-(void)testRuntimeIvar
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([Person class], &count);
    
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"%d %s %s",i,name,type);
    }
}

-(void)imageSwizzle
{
    //iOS swizzle 交换两个方法的实现
    self.imgvOne.image = [UIImage imageNamed:@"home"];
    self.imgvTwo.image = [UIImage imageNamed:@"consulting"];
    
    
    [self.names addObject:@"jack"];
    [self.names addObject:@"rose"];
    [self.names addObject:@"mary"];
    [self.names addObject:nil];
    
    self.books = @[@"aaa",@"bbb"];
    
    NSLog(@"%@",[self.books objectAtIndex:4]);
    
}

-(void)testOne
{
    Person *p = [[Person alloc]init];
    
    [p eat];
    
    objc_msgSend(p, @selector(eat));
    
    [Person eat];
    
    [[Person class]eat];
    
    objc_msgSend([Person class], @selector(eat));
}


@end
