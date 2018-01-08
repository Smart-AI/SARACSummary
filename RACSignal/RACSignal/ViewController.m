//
//  ViewController.m
//  RACSignal
//
//  Created by Smart-AI on 08/01/2018.
//  Copyright © 2018 Smart-AI. All rights reserved.
//
#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"send"];//发送信号
        //取消返回 RACDisposable
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号已经取消订阅");//取消订阅

        }];
       
    }];
    
    //订阅信号
    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"发送的信号是%@",x);
    }];
    
    [disposable dispose];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
