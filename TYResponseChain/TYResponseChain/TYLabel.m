//
//  TYLabel.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/8/24.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYLabel.h"

@implementation TYLabel
/** 不管控件是通过xib stroyboard 还是纯代码  提供两种初始化的操作都调用同一个方法 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupTap];
    }
    return self;
}
/** 不管控件是通过xib stroyboard 还是纯代码  提供两种初始化的操作都调用同一个方法 */
- (void)awakeFromNib
{
    [self setupTap];
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    NSLog(@"反应范围B:%@ 事件:%@",NSStringFromCGPoint(point),event);
//    //    if ([self.layer containsPoint:point]){
//    //        return self;
//    //    }else{
//    //        return nil;
//    //    }
//        return [super hitTest:point withEvent:event];
//}
//
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    NSLog(@"触控范围B:%@ 事件:%@",NSStringFromCGPoint(point),event);
//    //    if ([self.layer containsPoint:point]){
//    //        return YES;
//    //    }else{
//    //        return NO;
//    //    }
//    return NO;
//}

/** 设置敲击手势 */
- (void)setupTap
{
    
    self.text = @"author:会跳舞的狮子";
//    [self becomeFirstResponder];
    //已经在stroyboard设置了与用户交互,也可以用纯代码设置
    self.userInteractionEnabled = YES;
    
    //当前控件是label 所以是给label添加敲击手势
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)]];
    
}
/** 点击label触发的方法 */
- (void)labelClick
{
    // 让label成为第一响应者 \
    一定要写这句话  因为这句话才是主动让label成为第一响应者
    [self becomeFirstResponder];
    
    // 获得菜单
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    // 设置菜单内容 \
    因为menuItems是数组 官方没有给出需要传入什么对象,但是以经验可以判断出需要传入的是UIMenuItem对象 \
    而且显示是按顺序的
    menu.menuItems = @[
                       [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)],
                       [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(reply:)],
                       [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(warn:)]
                       ];
    
    // 菜单最终显示的位置 \
    有两种方式: 一种是以自身的bounds  还有一种是以父控件的frame
    [menu setTargetRect:self.bounds inView:self];
    //    [menu setTargetRect:self.frame inView:self.superview];
    
    // 显示菜单
    [menu setMenuVisible:YES animated:YES];
}



#pragma mark - UIMenuController相关
/**
 * 让Label具备成为第一响应者的资格
 */
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

/**
 * 通过第一响应者的这个方法告诉UIMenuController可以显示什么内容
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ( (action == @selector(copy:) && self.text) // 需要有文字才能支持复制
        || (action == @selector(cut:) && self.text) // 需要有文字才能支持剪切
        || action == @selector(paste:)
        || action == @selector(ding:)
        || action == @selector(reply:)
        || action == @selector(warn:)) return YES;
    
    return NO;
}

#pragma mark - 监听MenuItem的点击事件
/** 剪切 */
- (void)cut:(UIMenuController *)menu
{
    //UIPasteboard 是可以在应用程序与应用程序之间共享的 \
    (应用程序:你的app就是一个应用程序 比如你的QQ消息可以剪切到百度查找一样)
    // 将label的文字存储到粘贴板
    [UIPasteboard generalPasteboard].string = self.text;
    // 清空文字
    self.text = nil;
}
/** 赋值 */
- (void)copy:(UIMenuController *)menu
{
    // 将label的文字存储到粘贴板
    [UIPasteboard generalPasteboard].string = self.text;
}
/** 粘贴 */
- (void)paste:(UIMenuController *)menu
{
    // 将粘贴板的文字赋值给label
    self.text = [UIPasteboard generalPasteboard].string;
}

//如果方法不实现,是不会显示出来的
- (void)ding:(UIMenuController *)menu
{
    NSLog(@"%s %@", __func__, menu);
}

- (void)reply:(UIMenuController *)menu
{
    NSLog(@"%s %@", __func__, menu);
}

- (void)warn:(UIMenuController *)menu
{
    NSLog(@"%s %@", __func__, menu);
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
