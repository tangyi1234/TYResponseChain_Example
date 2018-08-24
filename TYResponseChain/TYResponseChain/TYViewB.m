//
//  TYViewB.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/8/24.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYViewB.h"
#import "TYLabel.h"

@implementation TYViewB
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initButView];
    }
    return self;
}

- (void)initButView{
    [self becomeFirstResponder];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(10, 10, 100, 30);
    but.backgroundColor = [UIColor greenColor];
    [but addTarget:self action:@selector(selectorBut) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:but];
    
    TYLabel *lbl = [[TYLabel alloc] initWithFrame:CGRectMake(20, 50, 120, 30)];
    [self addSubview:lbl];
}

- (void)selectorBut{
    NSLog(@"点击");
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"反应范围B:%@ 事件:%@",NSStringFromCGPoint(point),event);
//    if ([self.layer containsPoint:point]){
//        return self;
//    }else{
//        return nil;
//    }
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"触控范围B:%@ 事件:%@",NSStringFromCGPoint(point),event);
//    if ([self.layer containsPoint:point]){
//        return YES;
//    }else{
//        return NO;
//    }
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
