//
//  TYRunLoopViewController.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/9/19.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYRunLoopViewController.h"
#import "TYWorkerClass.h"
#define kMsg1 100
#define kMsg2 101

@interface TYRunLoopViewController ()<UIScrollViewDelegate,NSMachPortDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) NSThread *thr;
@property (nonatomic, strong) TYWorkerClass *work;
@property (nonatomic, strong) NSThread *thread;
@end

@implementation TYRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initButView];
}

- (void)initButView{
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    but1.frame = CGRectMake(10, 64, 200, 30);
    but1.backgroundColor = [UIColor redColor];
    [but1 setTitle:@"使用ScrollView" forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(initScrollView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but1];
    
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    but2.frame = CGRectMake(10, 100, 200, 30);
    but2.backgroundColor = [UIColor yellowColor];
    [but2 setTitle:@"子线程" forState:UIControlStateNormal];
    [but2 addTarget:self action:@selector(selectorBut2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but2];
    
    UIButton *but3 = [UIButton buttonWithType:UIButtonTypeCustom];
    but3.frame = CGRectMake(10, 140, 200, 30);
    but3.backgroundColor = [UIColor redColor];
    [but3 setTitle:@"线程间通信" forState:UIControlStateNormal];
    [but3 addTarget:self action:@selector(selectorBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but3];
}

- (void)initScrollView{
    UIScrollView *scView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    scView.delegate = self;
    scView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    scView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_scrollView = scView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    imageView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_imageView = imageView];
    
//    [self dealWithGCD];
    [self dealWithObserver];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"滑动的位置:%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y != -64) {
        
    }
    
}

- (void)dealWithImageView{
    //  [self.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"add_choose_But"] afterDelay:2.0 ];
    //  [self.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"group_photo"] afterDelay:2.0 inModes:@[NSDefaultRunLoopMode,UITrackingRunLoopMode]];
}

- (void)dealWithGCD{
    //创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //1.创建一个GCD定时器
    /*
     第一个参数:表明创建的是一个定时器
     第四个参数:队列
     */
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 需要对timer进行强引用，保证其不会被释放掉，才会按时调用block块
    // 局部变量，让指针强引用
    self.timer = timer;
    //2.设置定时器的开始时间,间隔时间,精准度
    /*
     第1个参数:要给哪个定时器设置
     第2个参数:开始时间
     第3个参数:间隔时间
     第4个参数:精准度 一般为0 在允许范围内增加误差可提高程序的性能
     GCD的单位是纳秒 所以要*NSEC_PER_SEC
     */
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    //3.设置定时器要执行的事情
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"---%@--",[NSThread currentThread]);
    });
    // 启动
    dispatch_resume(timer);
}

- (void)dealWithObserver{
    //创建监听者
    /*
     第一个参数 CFAllocatorRef allocator：分配存储空间 CFAllocatorGetDefault()默认分配
     第二个参数 CFOptionFlags activities：要监听的状态 kCFRunLoopAllActivities 监听所有状态
     第三个参数 Boolean repeats：YES:持续监听 NO:不持续
     第四个参数 CFIndex order：优先级，一般填0即可
     第五个参数 ：回调 两个参数observer:监听者 activity:监听的事件
     */
    /*
     所有事件
     typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
     kCFRunLoopEntry = (1UL << 0),   //   即将进入RunLoop
     kCFRunLoopBeforeTimers = (1UL << 1), // 即将处理Timer
     kCFRunLoopBeforeSources = (1UL << 2), // 即将处理Source
     kCFRunLoopBeforeWaiting = (1UL << 5), //即将进入休眠
     kCFRunLoopAfterWaiting = (1UL << 6),// 刚从休眠中唤醒
     kCFRunLoopExit = (1UL << 7),// 即将退出RunLoop
     kCFRunLoopAllActivities = 0x0FFFFFFFU
     };
     */
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"RunLoop进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"RunLoop要处理Timers了");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"RunLoop要处理Sources了");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"RunLoop要休息了");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"RunLoop醒来了");
                break;
            case kCFRunLoopExit:
                NSLog(@"RunLoop退出了");
                break;
                
            default:
                break;
        }
    });
    
    // 给RunLoop添加监听者
    /*
     第一个参数 CFRunLoopRef rl：要监听哪个RunLoop,这里监听的是主线程的RunLoop
     第二个参数 CFRunLoopObserverRef observer 监听者
     第三个参数 CFStringRef mode 要监听RunLoop在哪种运行模式下的状态
     */
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    /*
     CF的内存管理（Core Foundation）
     凡是带有Create、Copy、Retain等字眼的函数，创建出来的对象，都需要在最后做一次release
     GCD本来在iOS6.0之前也是需要我们释放的，6.0之后GCD已经纳入到了ARC中，所以我们不需要管了
     */
    CFRelease(observer);
}

- (void)selectorBut2{
    NSThread *thr = [[NSThread alloc] initWithTarget:self selector:@selector(show) object:nil];
    //如果不添加强引用，出了括号就线程就退出了，runLoop也就没有了。
    self.thr = thr;
    [thr start];
}

- (void)show{
    // 注意：打印方法一定要在RunLoop创建开始运行之前，如果在RunLoop跑起来之后打印，RunLoop先运行起来，已经在跑圈了就出不来了，进入死循环也就无法执行后面的操作了。
    // 但是此时点击Button还是有操作的，因为Button是在RunLoop跑起来之后加入到子线程的，当Button加入到子线程RunLoop就会跑起来
    NSLog(@"%s",__func__);
    // 1.创建子线程相关的RunLoop，在子线程中创建即可，并且RunLoop中要至少有一个Timer 或 一个Source 保证RunLoop不会因为空转而退出，因此在创建的时候直接加入
    // 添加Source [NSMachPort port] 添加一个端口
    [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    // 添加一个Timer
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(selectorBut3) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    //创建监听者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"RunLoop进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"RunLoop要处理Timers了");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"RunLoop要处理Sources了");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"RunLoop要休息了");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"RunLoop醒来了");
                break;
            case kCFRunLoopExit:
                NSLog(@"RunLoop退出了");
                break;
                
            default:
                break;
        }
    });
    // 给RunLoop添加监听者
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    // 2.子线程需要开启RunLoop
    [[NSRunLoop currentRunLoop]run];
    CFRelease(observer);
    /**
     通过打印的发现，只有第一次加入到runLoop的时候才会执行kCFRunLoopEntry，其它时候都是不会执行的。Timer是通过唤醒来实现的。
     */
}

- (void)selectorBut3{
    NSLog(@"%@",[NSThread currentThread]);
}
//线程间通信
- (void)selectorBut{
    //1. 创建主线程的port
    // 子线程通过此端口发送消息给主线程
    NSPort *myPort = [NSMachPort port];
    
    //2. 设置port的代理回调对象
    myPort.delegate = self;
    
    //3. 把port加入runloop，接收port消息
    [[NSRunLoop currentRunLoop] addPort:myPort forMode:NSDefaultRunLoopMode];
    
    NSLog(@"---myport %@", myPort);
    //4. 启动次线程,并传入主线程的port(开启次线程的目的是实现与主线程的交互)。这里的TYWorkerClass代码执行一定要在子线程中运行，如果是在主线中调TYWorkerClass的，那么他只会在主线程中运行。
    _work = [[TYWorkerClass alloc] init];
//    [_work interfaceWithPort:myPort];
//    self.thread = [[NSThread alloc]initWithTarget:_work selector:@selector(launchThreadWithPort:) object:myPort];
//    [self.thread start];
    [NSThread detachNewThreadSelector:@selector(launchThreadWithPort:)
                             toTarget:_work
                           withObject:myPort];
    
    
    
//    NSPort *port = [NSMachPort port];
//    if (port) {
//        port.delegate = self;
//        //创建一个线程
//        [[NSThread currentThread] setName:@"launchThreadForPort---Thread"];
//        [[NSRunLoop currentRunLoop] addPort:port forMode:NSDefaultRunLoopMode];
//
//        TYWorkerClass *work  = [[TYWorkerClass alloc] init];
//        [NSThread detachNewThreadSelector:@selector(launchThreadWithPort:) toTarget:work withObject:port];
//
//    }
}

- (void)handlePortMessage:(NSMessagePort*)message{
    
    NSLog(@"接到子线程传递的消息！%@",message);
    
    //1. 消息id
    NSUInteger msgId = [[message valueForKeyPath:@"msgid"] integerValue];
    
    //2. 当前主线程的port
    NSPort *localPort = [message valueForKeyPath:@"localPort"];
    NSLog(@"主线程端口:%@",localPort);
    //3. 接收到消息的port（来自其他线程）
    NSPort *remotePort = [message valueForKeyPath:@"remotePort"];
    NSLog(@"还有子线程吗:%@",remotePort);
    if (msgId == kMsg1)
    {
        NSLog(@"当前线程是什么:%@",[NSThread currentThread]);
        NSLog(@"对像是否为空:%@",_work);
        [_work getCurrentThread];
        //向子线的port发送消息
//        BOOL a = [remotePort sendBeforeDate:[NSDate date]
//                             msgid:kMsg2
//                        components:nil
//                              from:localPort
//                          reserved:0];
        
        BOOL a = [localPort sendBeforeDate:[NSDate date]
                                      msgid:kMsg2
                                 components:nil
                                       from:remotePort
                                   reserved:0];
        NSLog(@"是否发送成功:%d",a);
        //这里无法用于子线程进行线程交互，不知道是什么原因
        
    } else if (msgId == kMsg2){
        NSLog(@"操作2....\n");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
