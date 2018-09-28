//
//  TYWorkerClass.h
//  TYResponseChain
//
//  Created by 汤义 on 2018/9/25.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYWorkerClass : NSObject
- (void)launchThreadWithPort:(NSPort *)port;
- (void)interfaceWithPort:(NSPort *)port;
- (void)getCurrentThread;
@end
