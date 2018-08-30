//
//  TYRuntimeSuperViewController.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/8/30.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYRuntimeSuperViewController.h"

@interface TYRuntimeSuperViewController ()

@end

@implementation TYRuntimeSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initBut];
    [self initImageView];
}

- (void)initBut{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(10, 80, 200, 40);
    but.backgroundColor = [UIColor redColor];
    [but setTitle:@"按钮" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(selectorBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
}

- (void)selectorBut{
    
}

- (void)initImageView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 130, 300, 200)];
    imageView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:imageView];
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
