//
//  TYPortViewController.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/9/26.
//  Copyright © 2018年 汤义. All rights reserved.
//  线程间进行通讯

#import "TYPortViewController.h"

@interface TYPortViewController ()<NSMachPortDelegate,NSPortDelegate>
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIImageView *imageView1;
@property (nonatomic, strong) NSThread *thread;
@property (nonatomic, strong) UIImage *img1;
@property (nonatomic, strong) UIImage *img2;
@end

@implementation TYPortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initButView];
}

- (void)initButView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 140, 300, 300)];
    imageView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_imageView = imageView];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 500, 300, 300)];
    imageView1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_imageView1 = imageView1];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(10, 80, 200, 30);
    but.backgroundColor = [UIColor redColor];
    [but setTitle:@"向主线程" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(selectorBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    but1.frame = CGRectMake(220, 80, 200, 30);
    but1.backgroundColor = [UIColor yellowColor];
    [but1 setTitle:@"向子线程" forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(selectorBut1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but1];
    
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    but2.frame = CGRectMake(10, 445, 200, 30);
    but2.backgroundColor = [UIColor greenColor];
    [but2 setTitle:@"主向子发送消息" forState:UIControlStateNormal];
    [but2 addTarget:self action:@selector(selectorBut2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but2];
}

- (void)selectorBut{
  /**
   创建子线程，在子线程中进行图片的加载
   */
    [self performSelectorInBackground:@selector(childThreadLoad) withObject:nil];
}


- (void)selectorBut1{
    //开辟一个子线程
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(childThreadSele) object:nil];
    [thread start];
    NSLog(@"子线程是否还在执行:%d",[thread isExecuting]);
    [self performSelector:@selector(lordSonSele) onThread:thread withObject:nil waitUntilDone:NO];
}

- (void)selectorBut2{
    //是否正在执行
//    NSLog(@"子线程是否还在执行:%d",[self.thread isExecuting]);
//    NSLog(@"在这里子线程是否还在执行:%d",[self.thread isExecuting]);
    [self.thread isExecuting];
//    [self performSelector:@selector(lordSonSele) onThread:self.thread withObject:nil waitUntilDone:NO];
    [self performSelectorInBackground:@selector(lordSonSele) withObject:nil];
}

- (void)threadRun{
    NSLog(@"当前线程是什么:%@",[NSThread currentThread]);
    [self lordSonSele];
}

- (void)childThreadLoad{
    
    NSLog(@"当前线程是什么:%@",[NSThread currentThread]);
    //img路径字符串
    NSString *imgStr = @"http://10.10.61.218:8080/name/8.png";
    //将url加载到NSURL中
    NSURL *imgUrl = [NSURL URLWithString:imgStr];
    //根据url加载成data数据
    NSData *data = [NSData dataWithContentsOfURL:imgUrl];
    //加载完毕将data数据装换为UIImage中
    UIImage *image = [UIImage imageWithData:data];
    //与主线程进行交互，将图片到主线中加载出来d
    if (image != nil) {
        /*
         该方法放在主线程中运行。其中，aSelector就是在主线程中运行的方法，参数arg是当前执行方法所在的线程传递给主线程的参数，参数waitUntilDone是一个布尔值，用来指定当前线程是否阻塞，当为YES的时候会阻塞当前线程，直到主线程执行完毕后才执行当前线程；当为NO的时候，则不阻塞这个线程。
         */
        [self performSelectorOnMainThread:@selector(displayImages:) withObject:image waitUntilDone:NO];
    }else{
        NSLog(@"没有图片");
    }
    [self performSelector:@selector(threadRun)];
}

- (void)displayImages:(UIImage *)image{
    if (image != nil) {
        _imageView.image = image;
    }else{
        NSLog(@"没有加载图片");
    }
}
//第一个子线程加载数据
- (void)childThreadSele{
    //柱塞当前线程
//    [NSThread sleepForTimeInterval:10.0];
    //设置线程名称
    [[NSThread currentThread] setName:@"childThreadName"];
    _img1 = [self processingImages:@"http://10.10.61.218:8080/name/6.png"];
    while (1){
        if ([[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]) //相当于join
            {
                NSLog(@"线程B结束");
                break;
            }
        }
}

- (void)lordSonSele{
    NSLog(@"第二个线程");
    [[NSThread currentThread] setName:@"lordSonThreadName"];
    _img2 = [self processingImages:@"http://10.10.61.218:8080/name/12.png"];
    if (_img1 != nil) {
        /*
         该方法放在主线程中运行。其中，aSelector就是在主线程中运行的方法，参数arg是当前执行方法所在的线程传递给主线程的参数，参数waitUntilDone是一个布尔值，用来指定当前线程是否阻塞，当为YES的时候会阻塞当前线程，直到主线程执行完毕后才执行当前线程；当为NO的时候，则不阻塞这个线程。
         */
        [self performSelectorOnMainThread:@selector(displayImages:) withObject:_img1 waitUntilDone:NO];
    }else{
        NSLog(@"没有图片");
    }
    
    if (_img2 != nil) {
        /*
         该方法放在主线程中运行。其中，aSelector就是在主线程中运行的方法，参数arg是当前执行方法所在的线程传递给主线程的参数，参数waitUntilDone是一个布尔值，用来指定当前线程是否阻塞，当为YES的时候会阻塞当前线程，直到主线程执行完毕后才执行当前线程；当为NO的时候，则不阻塞这个线程。
         */
        [self performSelectorOnMainThread:@selector(accordingImage:) withObject:_img2 waitUntilDone:NO];
    }else{
        NSLog(@"没有图片");
    }
}

- (UIImage *)processingImages:(NSString *)imgStr{
    NSLog(@"当前线程是什么:%@",[NSThread currentThread]);
    //将url加载到NSURL中
    NSURL *imgUrl = [NSURL URLWithString:imgStr];
    //根据url加载成data数据
    NSData *data = [NSData dataWithContentsOfURL:imgUrl];
    //加载完毕将data数据装换为UIImage中
    UIImage *image = [UIImage imageWithData:data];
    
    return image;
}

- (void)accordingImage:(UIImage *)img{
    if (img != nil) {
        _imageView1.image = img;
    }else{
        NSLog(@"没有加载图片");
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
