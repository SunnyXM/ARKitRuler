//
//  ViewController.m
//  ARRuler
//
//  Created by XM on 2017/11/9.
//  Copyright © 2017年 my. All rights reserved.
//

#import "ViewController.h"
#import "ARRulerController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *doArBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, self.view.frame.size.width-200, 50)];
    
    [doArBtn addTarget:self action:@selector(doArKit) forControlEvents:UIControlEventTouchUpInside];
    [doArBtn setTitle:@"AR尺子" forState:UIControlStateNormal];
    [doArBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doArBtn setBackgroundColor:[UIColor blueColor]];
    doArBtn.tag = 100;
    [self.view addSubview:doArBtn];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)doArKit{
    ARRulerController *arVC = [[ARRulerController alloc] init];
    [self.navigationController pushViewController:arVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end






