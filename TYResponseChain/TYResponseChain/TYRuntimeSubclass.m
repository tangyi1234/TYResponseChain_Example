//
//  TYRuntimeSubclass.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/8/30.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYRuntimeSubclass.h"
#import <objc/message.h>

@implementation TYRuntimeSubclass
- (void)performRuntime{
    NSLog(@"这是子类");
}
+ (void)performRuntimeClass{
    NSLog(@"类方法");
}
@end
