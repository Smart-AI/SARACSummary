//
//  ViewController.m
//  RACSubject
//
//  Created by Smart-AI on 08/01/2018.
//  Copyright © 2018 Smart-AI. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "NextViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)push:(id)sender {
    NextViewController *vc = [[NextViewController alloc] init];
    vc.subject = [RACSubject subject];
    [vc.subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"发送的信息是%@",x);
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
