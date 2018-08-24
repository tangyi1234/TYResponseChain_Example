//
//  TYViewA.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/8/24.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYViewA.h"

@implementation TYViewA
/**
 * 此方法会返回能够处理事件的控件，可以用来拦截所有的触摸事件；
 * 如果返回nil，则表示该控件不能处理事件，则事件会向上传递；反之则不会再传递事件；
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    NSLog(@"反应范围A:%@ 事件:%@",NSStringFromCGPoint(point),event);
//    if ([self.layer containsPoint:point]){
//        return self;
//    }else{
//        return nil;
//    }
//    return nil;
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"触控范围A:%@ 事件:%@",NSStringFromCGPoint(point),event);
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
