//
//  TYViewController.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/8/29.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYViewController.h"
#import "ViewController.h"
#import "TYRuntimeViewController.h"
#import "TYButViewController.h"
#import "TYRunLoopViewController.h"
#import "TYPortViewController.h"
@interface TYViewController ()

@end

@implementation TYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initButView];
}

- (void)initButView{
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    but1.frame = CGRectMake(10, 80, 150, 40);
    but1.backgroundColor = [UIColor redColor];
    [but1 setTitle:@"响应链" forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(selectorBut1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but1];
    
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    but2.frame = CGRectMake(10, 130, 150, 40);
    but2.backgroundColor = [UIColor yellowColor];
    [but2 setTitle:@"runtime" forState:UIControlStateNormal];
    [but2 addTarget:self action:@selector(selectorBut2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but2];
    
    UIButton *but3 = [UIButton buttonWithType:UIButtonTypeCustom];
    but3.frame = CGRectMake(10, 180, 150, 40);
    but3.backgroundColor = [UIColor greenColor];
    [but3 setTitle:@"按钮" forState:UIControlStateNormal];
    [but3 addTarget:self action:@selector(selectorBut3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but3];
    
    UIButton *but4 = [UIButton buttonWithType:UIButtonTypeCustom];
    but4.frame = CGRectMake(10, 230, 150, 40);
    but4.backgroundColor = [UIColor yellowColor];
    [but4 setTitle:@"处理问题" forState:UIControlStateNormal];;
    [but4 addTarget:self action:@selector(selectorBut4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but4];
    
    UIButton *but5 = [UIButton buttonWithType:UIButtonTypeCustom];
    but5.frame = CGRectMake(10, 280, 150, 30);
    but5.backgroundColor = [UIColor redColor];
    [but5 setTitle:@"runloop按钮" forState:UIControlStateNormal];
    [but5 addTarget:self action:@selector(selectorBut5) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but5];
    
    UIButton *but6 = [UIButton buttonWithType:UIButtonTypeCustom];
    but6.frame = CGRectMake(10, 320, 200, 30);
    but6.backgroundColor = [UIColor yellowColor];
    [but6 setTitle:@"线程间通信" forState:UIControlStateNormal];
    [but6 addTarget:self action:@selector(selectorBut6) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but6];
}

- (void)selectorBut1{
    ViewController *view = [[ViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)selectorBut2{
    TYRuntimeViewController *vc = [[TYRuntimeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selectorBut3 {
    TYButViewController *vc = [[TYButViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selectorBut4{
//    TYClickQuestionViewController*VC = [[TYClickQuestionViewController alloc] init];
//    [self.navigationController pushViewController:VC animated:YES];
}

- (void)selectorBut5{
    TYRunLoopViewController *vc = [[TYRunLoopViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selectorBut6{
    TYPortViewController *poVc = [[TYPortViewController alloc] init];
    [self.navigationController pushViewController:poVc animated:YES];
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
