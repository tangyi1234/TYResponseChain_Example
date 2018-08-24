//
//  UIResponder+TYResponder.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/8/24.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "UIResponder+TYResponder.h"

@implementation UIResponder (TYResponder)
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    NSLog(@"这是那个点击:%@",[self nextResponder]);
    NSLog(@"eventName:%@ userInfo:%@",eventName,userInfo);
//    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

- (void)findNextResponder{
    NSLog(@"这是那个点击:%@",[self nextResponder]);
}
@end
