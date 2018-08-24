//
//  ViewController.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/8/24.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "ViewController.h"
#import "TYImportCategory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initView];
}

- (void)initView{
    TYViewA *vA = [[TYViewA alloc] initWithFrame:CGRectMake(0, 64, W, H - 64)];
    vA.backgroundColor = [UIColor redColor];
    [self.view addSubview:vA];
    
    TYViewB *vB = [[TYViewB alloc] initWithFrame:CGRectMake(10, 10, W - 20, 200)];
    vB.backgroundColor = [UIColor yellowColor];
    [vA addSubview:vB];
    
    TYViewC *vC = [[TYViewC alloc] initWithFrame:CGRectMake(10, 10, vB.frame.size.width - 20, vB.frame.size.height - 10)];
    vC.backgroundColor = [UIColor clearColor];
    [vB addSubview:vC];
    
    TYViewD *vD = [[TYViewD alloc] initWithFrame:CGRectMake(10, 230, W - 20, 200)];
    vD.backgroundColor = [UIColor yellowColor];
    [vA addSubview:vD];
    
    TYViewE *vE = [[TYViewE alloc] initWithFrame:CGRectMake(10, 10, vD.frame.size.width - 20, vD.frame.size.height - 20)];
    vE.backgroundColor = [UIColor redColor];
    [vD addSubview:vE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
