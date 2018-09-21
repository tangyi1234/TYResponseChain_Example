//
//  TYFoo.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/9/18.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYFoo.h"
#import <objc/runtime.h>
void dynamicMethodIMP(id self, SEL _cmd) {
    NSLog(@" >> dynamicMethodIMP");
}
@implementation TYFoo
@dynamic weight;

void setPropertyDynamic(id self,SEL _cmd){
    NSLog(@"This is a dynamic method added for Person instance");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(setWeight:)){
        class_addMethod([self class], sel,(IMP)setPropertyDynamic, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

- (void)foo {
    NSLog(@"Doing foo");//Person的foo函数
}
@end
