//
//  TYFoo.h
//  TYResponseChain
//
//  Created by 汤义 on 2018/9/18.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYFoo : NSObject
+ (void)Bar;
+ (void)MissMethod;
- (void)foo;
@property(assign,nonatomic)NSInteger weight;
@end
