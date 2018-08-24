//
//  UIResponder+TYResponder.h
//  TYResponseChain
//
//  Created by 汤义 on 2018/8/24.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (TYResponder)
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;
- (void)findNextResponder;
@end
