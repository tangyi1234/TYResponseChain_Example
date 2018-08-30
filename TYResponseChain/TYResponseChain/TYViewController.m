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
}

- (void)selectorBut1{
    ViewController *view = [[ViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)selectorBut2{
    TYRuntimeViewController *vc = [[TYRuntimeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
