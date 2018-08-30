//
//  TYRuntimeViewController.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/8/29.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYRuntimeViewController.h"
#import <objc/runtime.h>
#import "TYRuntime.h"
#import "TYRuntimeSubclass.h"
@interface TYRuntimeViewController ()

@end

@implementation TYRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self initButView];
    [self initIsa];
}
//获取方法的名称
- (void)initButView {
    /*
     runtime方法其实在这里提供的是最底层方法，这里没有说什么机制。
     */
    unsigned int count;
    //获取父类
    Class cla = class_getSuperclass(self.class);
    NSString *className =NSStringFromClass(cla);
    NSLog(@"类名:%@",className);
    //获取方法列表
    Method *allMethods = class_copyMethodList(cla, &count);
    for (unsigned int i = 0; i < count; i ++) {
        Method method = allMethods[i];
        //获取方法名称
        SEL methodName = method_getName(method);
        NSString *methodStr = NSStringFromSelector(methodName);
        NSLog(@"方法名称:%@",methodStr);
    }
    free(allMethods);
}

- (void)initImageView {

}
//获取对象的isa
- (void)initIsa{
    NSLog(@"获取类的isa:%p",[TYRuntime class]);
    TYRuntime *isa = [[TYRuntime alloc] init];
    NSLog(@"获取isa1:%p", [isa class]);
    NSLog(@"获取isa2:%p",object_getClass(isa));
    NSLog(@"直接打印是什么地址:%p",isa);
    /**
     2018-08-30 16:26:34.548 TYResponseChain[3630:202457] 获取类的isa:0x10ab73720
     2018-08-30 16:26:34.549 TYResponseChain[3630:202457] 获取isa1:0x10ab73720
     2018-08-30 16:26:34.549 TYResponseChain[3630:202457] 获取isa2:0x10ab73720
     这是什么原因了，没有实例化的时候和实例化的打印的地址都是一样的。
     */
    
    TYRuntimeSubclass *suIsa = [[TYRuntimeSubclass alloc] init];
    NSLog(@"获取之类的isa:%p",[suIsa class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
