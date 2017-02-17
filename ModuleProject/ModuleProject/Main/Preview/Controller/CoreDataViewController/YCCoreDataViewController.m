//
//  YCCoreDataViewController.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/16.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "YCCoreDataViewController.h"
#import "Person+CoreDataClass.h"


@interface YCCoreDataViewController ()

@end

@implementation YCCoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    showAlert(@"请查看YCCoreDataViewController.m代码");
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self coreDataSetting];
}

- (void)coreDataSetting
{
    // 实体对象的创建保存和更新
    
    // 1.获取上下文环境
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    
    // 2.在当前上下文环境中创建一个新的Person对象
    Person *person = [Person MR_createEntityInContext:defaultContext];
    person.name = @"Twinkle";
    person.age = 23;
    person.tall = 183;
    person.sex = 1;  // 0 女  1男
    
    // 3.保存修改到当前上下文中
    [defaultContext MR_saveToPersistentStoreAndWait];
    
    // 4.获取数据库中person内容
    NSArray *persons = [Person MR_findAll];
    for (Person *obj in persons) {
        YCLog(@"%@------%hd-----%d-----%hd",obj.name,obj.age,obj.tall,obj.sex);
    }
    
}


@end
