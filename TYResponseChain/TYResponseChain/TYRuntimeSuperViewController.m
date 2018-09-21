//
//  TYRuntimeSuperViewController.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/8/30.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYRuntimeSuperViewController.h"
#import "TYRuntimeView.h"
#import "TYRuntimeSubclass.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "TYFoo.h"
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
    
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    but1.frame = CGRectMake(10, 130, 200, 40);
    but1.backgroundColor = [UIColor yellowColor];
    [but1 setTitle:@"按钮1" forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(selectorBut1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but1];
    
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    but2.frame = CGRectMake(10, 180, 200, 40);
    but2.backgroundColor = [UIColor greenColor];
    [but2 addTarget:self action:@selector(selectorBut2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but2];
    
    UIButton *but3 = [UIButton buttonWithType:UIButtonTypeCustom];
    but3.frame = CGRectMake(10, 230, 200, 40);
    but3.backgroundColor = [UIColor redColor];
    [but3 setTitle:@"按钮3" forState:UIControlStateNormal];
    [but3 addTarget:self action:@selector(selectorBut3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but3];
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
          
//    Class metaCls2 = object_getClass(metaCls1);
//    NSLog(@"这里的isa:%p",metaCls2);
//    NSLog(@"metaCls2类名:%@",[self getRtr:metaCls2]);
//    Class metaCls3 = object_getClass(metaCls2);
//    NSLog(@"这里的isa:%p",metaCls3);
//    NSLog(@"metaCls3类名:%@",[self getRtr:metaCls3]);
//    Class metaCls4 = object_getClass(metaCls3);
//    NSLog(@"这里的isa:%p",metaCls4);
//    NSLog(@"metaCls4类名:%@",[self getRtr:metaCls4]);
//
//    //superClass
//    Class superCls1 = class_getSuperclass(cls);
//    NSLog(@"父类这里的isa1:%p",superCls1);
//    NSLog(@"父类类名1:%@",[self getRtr:superCls1]);
//    Class superCls2 = class_getSuperclass(superCls1);
//    NSLog(@"父类这里的isa2:%p",superCls2);
//    NSLog(@"父类类名2:%@",[self getRtr:superCls2]);
//    Class superCls3 = class_getSuperclass(superCls2);
//    NSLog(@"父类这里的isa3:%p",superCls3);
//    NSLog(@"父类类名3:%@",[self getRtr:superCls3]);
//    Class superCls4 = class_getSuperclass(superCls3);
//    NSLog(@"父类这里的isa4:%p",superCls4);
//    NSLog(@"父类类名:%@4",[self getRtr:superCls4]);

    
}

- (void)selectorBut1{
    TYRuntimeSubclass *subclass = [[TYRuntimeSubclass alloc] init];
    Class cla = object_getClass(subclass);
    NSLog(@"类名:%@",[self getRtr:cla]);
    [self initButView:cla];
    Class suCla = class_getSuperclass(cla);
    NSLog(@"类名:%@",[self getRtr:suCla]);
    [self initButView:suCla];
}

- (void)selectorBut2{
    /**
     struct objc_super supersSuper;
     supersSuper.receiver = self;
     supersSuper.super_class = object_getClass(class_getSuperclass(class_getSuperclass(self)));
     
     return objc_msgSendSuper(&supersSuper, _cmd);
     */
    TYRuntimeSubclass *subclass = [[TYRuntimeSubclass alloc] init];
    objc_msgSend(subclass, @selector(performRuntime));
    objc_msgSend([TYRuntimeSubclass class], @selector(performRuntimeClass));
//    objc_msgSendSuper((__bridge struct objc_super *)(class_getSuperclass(subclass)), @selector(performRuntime));
//    NSLog(@"打印结果:%@",[TYRuntimeSubclass point]);
//    id a = [TYRuntimeSubclass parentClass];
//    NSLog(@"这是服类吗:%@",[TYRuntimeSubclass parentClass]);
//    NSLog(@"打印结果:%@",);
//    TYFoo *foo = [[TYFoo alloc] init];
//    foo.weight = 20;
}

- (void)selectorBut3{
    [self performSelector:@selector(foo)];
}
/**
 这是解析的第一阶段
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(foo)) {//这是用来仿制说明消息解析的过程，因为这没有实现foo的方法如果安照实际来说是会出现崩溃显现的。我们在这里就是将foo方法执行转化了执行fooMethod方法。
        class_addMethod([self class], sel, (IMP)fooMethod, "v@");//这就包含那副经典图的流程
        return YES;
    }
    BOOL mothod = [super resolveInstanceMethod:sel];
    NSLog(@"这是个什么值:%d",mothod);
    return mothod;

}


void fooMethod(id obj , SEL _cmd){
    NSLog(@"执行foo:");
}

/**
 如果第一阶段是返回的为NO或YES都就会执行下一阶段，这里看执不执行下一阶段这里主要看的是有class_addMethod方法。如果是有就会抛除消息转发机制直接执行IMP方法，消息转发
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSString *str = NSStringFromSelector(aSelector);
    NSLog(@"打印这是什么方法:%@",str);
    if (aSelector == @selector(foo)) {
        return [TYFoo new];//返回TYFoo对象，让TYFoo对象接收这个消息
    }

    return [super forwardingTargetForSelector:aSelector];
}


/**
 走到这一步说上面两步都无法响应那个方法，这是最后一次机会了。进入这里的前提条件是第一步无法调用class_addMethod方法的IMP方法，和第二步是返回为nil。
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"foo"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];//签名，进入forwardInvocation
    }
    
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    
    TYFoo *foo = [TYFoo new];
    if([foo respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:foo];
    }
    else {
        [self doesNotRecognizeSelector:sel];
    }
    
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
