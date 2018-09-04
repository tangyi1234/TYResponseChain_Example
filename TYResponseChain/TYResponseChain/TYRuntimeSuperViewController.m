//
//  TYRuntimeSuperViewController.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/8/30.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYRuntimeSuperViewController.h"
#import "TYRuntimeView.h"
#import <objc/runtime.h>
@interface TYRuntimeSuperViewController ()

@end

@implementation TYRuntimeSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initBut];
    [self initImageView];
}

- (void)initBut{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(10, 80, 200, 40);
    but.backgroundColor = [UIColor redColor];
    [but setTitle:@"按钮" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(selectorBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
}

- (void)selectorBut{
    
    NSObject *objc = [[NSObject alloc] init];
    
    UIResponder *res = [[UIResponder alloc] init];
    
    UIView *view = [[UIView alloc] init];
    
    TYRuntimeView *runView = [[TYRuntimeView alloc] init];
    
    /**
     第一个方法获取到的是对象方法，
     第二个方法获取的是类方法
     第一个方法获取到了什么值，这都是根据我们传进来的类型有关
     */
    Class cls = object_getClass(objc);
    [self initButView:cls];
    NSLog(@"这里的isa:%p",cls);
    NSLog(@"类名:%@",[self getRtr:cls]);
    //metaClass
    Class metaCls1 = object_getClass(cls);
    [self initButView:metaCls1];
    NSLog(@"这里的isa:%p",metaCls1);
    NSLog(@"metaCls1类名:%@",[self getRtr:metaCls1]);
    Class metaCls2 = object_getClass(metaCls1);
    NSLog(@"这里的isa:%p",metaCls2);
    NSLog(@"metaCls2类名:%@",[self getRtr:metaCls2]);
    Class metaCls3 = object_getClass(metaCls2);
    NSLog(@"这里的isa:%p",metaCls3);
    NSLog(@"metaCls3类名:%@",[self getRtr:metaCls3]);
    Class metaCls4 = object_getClass(metaCls3);
    NSLog(@"这里的isa:%p",metaCls4);
    NSLog(@"metaCls4类名:%@",[self getRtr:metaCls4]);

    //superClass
    Class superCls1 = class_getSuperclass(cls);
    NSLog(@"父类这里的isa1:%p",superCls1);
    NSLog(@"父类类名1:%@",[self getRtr:superCls1]);
    Class superCls2 = class_getSuperclass(superCls1);
    NSLog(@"父类这里的isa2:%p",superCls2);
    NSLog(@"父类类名2:%@",[self getRtr:superCls2]);
    Class superCls3 = class_getSuperclass(superCls2);
    NSLog(@"父类这里的isa3:%p",superCls3);
    NSLog(@"父类类名3:%@",[self getRtr:superCls3]);
    Class superCls4 = class_getSuperclass(superCls3);
    NSLog(@"父类这里的isa4:%p",superCls4);
    NSLog(@"父类类名:%@4",[self getRtr:superCls4]);

    
}

- (NSString *)getRtr:(Class)cla{
    return NSStringFromClass(cla);
}

- (void)initButView:(Class)cla{
    /*
     runtime方法其实在这里提供的是最底层方法，这里没有说什么机制。
     */
    unsigned int count;
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

- (void)initImageView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 130, 300, 200)];
    imageView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:imageView];
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
