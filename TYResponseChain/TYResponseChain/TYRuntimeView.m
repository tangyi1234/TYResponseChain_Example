//
//  TYRuntimeView.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/9/4.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYRuntimeView.h"

@implementation TYRuntimeView
+ (void)classView{
    NSLog(@"类方法");
}
- (void)objcView{
    NSLog(@"对象方法");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
