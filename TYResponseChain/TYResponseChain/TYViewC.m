//
//  TYViewC.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/8/24.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYViewC.h"

@implementation TYViewC
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
//    // 判断对象是否不是第一响应者
//    if (![self isFirstResponder]) {
//        return;
//    }
//    // 判断对象是否允许放弃第一响应者
//    if ([self canResignFirstResponder]) {
//        // 设置放弃第一响应者
//        [self resignFirstResponder];
//    }
    [super resignFirstResponder];
}
/*
* 让View具备成为第一响应者的资格
*/
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"反应范围C:%@ 事件:%@",NSStringFromCGPoint(point),event);
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"触控范围C:%@ 事件:%@",NSStringFromCGPoint(point),event);
    if ([self.layer containsPoint:point]){
        return YES;
    }else{
        return NO;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
