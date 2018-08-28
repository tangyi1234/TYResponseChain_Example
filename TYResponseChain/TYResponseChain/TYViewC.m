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
//    [super resignFirstResponder];
    [self becomeFirstResponder];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(10, 10, 100, 30);
    but.backgroundColor = [UIColor redColor];
    [but addTarget:self action:@selector(selectorBut) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:but];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 120, 30)];
    lbl.text = @"12345";
    [self addSubview:lbl];
}
/*
* 让View具备成为第一响应者的资格
*/
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)selectorBut{
    NSLog(@"C上的按钮响应了");
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"反应范围C:%@ 事件:%@",NSStringFromCGPoint(point),event);
//    return [super hitTest:point withEvent:event];
//    UIView *hitView = [super hitTest:point withEvent:event];
//    if(hitView == self){
//        return nil;
//    }
//    return hitView;
    
//    UIView *view = [super hitTest:point withEvent:event];
//
//    NSLog(@"%@",view);
//    NSLog(@"%@",view.superview.superview);
//
//    if (view) {
//        return view.superview.superview;//view.superview; or view.superview.superview; or view.superview.superview.superview;... if has
//    }else
        return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"触控范围C:%@ 事件:%@",NSStringFromCGPoint(point),event);
//    if ([self.layer containsPoint:point]){
//        return YES;
//    }else{
//        return NO;
//    }
    return YES;
}

/** 手指按下时响应 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"--->手指按下时响应");
}

/** 手指移动时响应 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    NSLog(@"--->手指移动时响应");
}

/** 手指抬起时响应 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    NSLog(@"--->手指抬起时响应");
}

/** 触摸取消(意外中断, 如:电话, Home键退出等) */
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"--->取消触摸响应");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
