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
    
//    [self becomeFirstResponder];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(10, 10, 100, 30);
    but.backgroundColor = [UIColor redColor];
    [but addTarget:self action:@selector(selectorBut) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:but];
//
//    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 120, 30)];
//    lbl.text = @"12345";
//    [self addSubview:lbl];
    
//    NSLog(@"当前是否为第一响应者:%d",[super isFirstResponder]);
}


- (void)selectorBut{
//    [self resignFirstResponder];
    NSLog(@"C上的按钮响应了");
}

- (UIResponder *)nextResponder{
    NSLog(@"这里的Responder是什么:%@",[super nextResponder]);
    return [super nextResponder];
}

/**
 在UIResponder中用来获取或判断第一响应链方法处理，都是在执行hit_Test方法之后才进行处理的。我们在view创建和hit_Test方法中使用isFirstResponder和resignFirstResponder都是获取不到值的，这里就说明它们的赋值是在之后处理的。
 确定谁是第一响应者，只有通过下面两个方法来确定。
 */
//
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"反应范围C:%@ 事件:%@",NSStringFromCGPoint(point),event);
    [super resignFirstResponder];
    NSLog(@"我取消第一响应者成功了吗:%d",[super resignFirstResponder]);
    BOOL s = YES;
    NSLog(@"什么值:%d",s);
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"触控范围C:%@ 事件:%@",NSStringFromCGPoint(point),event);
//    if ([self.layer containsPoint:point]){
//        return YES;
//    }else{
//        return NO;
//    }
    return NO;
}
/**
 在这里重写方法是不会调用的，只有通过获取父类来获取。
//一个响应对象成为第一响应者的一个前提是它可以成为第一响应者,可以用这个进行判断，默认值为NO
- (BOOL)canBecomeFirstResponder{
    [super canBecomeFirstResponder];
    return YES;
}

//如果我们希望将一个响应对象作为第一响应者，则可以使用以下方法,如果对象成为第一响应者，则返回YES；否则返回NO
- (BOOL)becomeFirstResponder{
    return YES;
}


//是否可以辞去第一响应者,默认值为YES
- (BOOL)canResignFirstResponder {
   return YES;
}
//辞去第一响应者
- (BOOL)resignFirstResponder {
    return YES;
}


//判定一个响应对象是否是第一响应者
- (BOOL)isFirstResponder {
    return YES;
}
 */

/** 手指按下时响应 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"C--->手指按下时响应");
}

/** 手指移动时响应 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    NSLog(@"C--->手指移动时响应");
}

/** 手指抬起时响应 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    NSLog(@"C--->手指抬起时响应");
}

/** 触摸取消(意外中断, 如:电话, Home键退出等) */
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"C--->取消触摸响应");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
