//
//  TYWorkerClass.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/9/25.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYWorkerClass.h"
#define kMsg1 100
#define kMsg2 101
@interface TYWorkerClass()<NSMachPortDelegate>{
    NSPort *remotePort;
    NSPort *myPort;
}
@end
@implementation TYWorkerClass

- (void)launchThreadWithPort:(NSPort *)port {
    
    @autoreleasepool {
        
        //1. 保存主线程传入的port
        remotePort = port;
        
        //2. 设置子线程名字
        [[NSThread currentThread] setName:@"MyWorkerClassThread"];
        
        //3. 开启runloop
        [[NSRunLoop currentRunLoop] run];
        
        //4. 创建自己port
        myPort = [NSPort port];
        
        //5.
        myPort.delegate = self;
        
        //6. 将自己的port添加到runloop
        //作用1、防止runloop执行完毕之后推出
        //作用2、接收主线程发送过来的port消息
        [[NSRunLoop currentRunLoop] addPort:myPort forMode:NSDefaultRunLoopMode];
        
        NSLog(@"当前线程是什么:%@",[NSThread currentThread]);
        
        //7. 完成向主线程port发送消息
        [self sendPortMessage];
        
        
    }
}

//接口调用
- (void)interfaceWithPort:(NSPort *)port {
        //1. 保存主线程传入的port
        remotePort = port;
    
        //4. 创建自己port
        myPort = [NSPort port];
        
        //5.
        myPort.delegate = self;
        
        NSLog(@"当前线程是什么:%@",[NSThread currentThread]);
        
        //7. 完成向主线程port发送消息
        [self sendPortMessage];
}

/**
 *   完成向主线程发送port消息
 */
- (void)sendPortMessage {
    
    NSMutableArray *array  =[[NSMutableArray alloc]initWithArray:@[@"1",@"2"]];
    //发送消息到主线程，操作1
    BOOL a = [remotePort sendBeforeDate:[NSDate date]
                         msgid:kMsg1
                    components:array
                          from:myPort
                      reserved:0];
    NSLog(@"在子线程中是否发送成功:%d",a);
    
    //发送消息到主线程，操作2
//        [remotePort sendBeforeDate:[NSDate date]
//                             msgid:kMsg2
//                        components:nil
//                              from:myPort
//                          reserved:0];
}


#pragma mark - NSPortDelegate

/**
 *  接收到主线程port消息
 */
- (void)handlePortMessage:(NSPortMessage *)message
{
    NSLog(@"接收到父线程的消息...\n");
    
    //    unsigned int msgid = [message msgid];
    //    NSPort* distantPort = nil;
    //
    //    if (msgid == kCheckinMessage)
    //    {
    //        distantPort = [message sendPort];
    //
    //    }
    //    else if(msgid == kExitMessage)
    //    {
    //        CFRunLoopStop((__bridge CFRunLoopRef)[NSRunLoop currentRunLoop]);
    //    }
}

/**
 这里调用为什么是显示主线程了？这是因为我们在创建TYWorkerClass的时候，将它强引用到TYRunLoopViewController上了，然而它是在主线程上执行的，所以就会导致调getCurrentThread方法获取的当前线程就是主线程。
 */
- (void)getCurrentThread{
    NSLog(@"当前是什么线程:%@",[NSThread currentThread]);
}
@end
