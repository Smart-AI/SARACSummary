//
//  ViewController.m
//  RACMulticastConnection
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
}

- (IBAction)mutiSend:(id)sender {
    RACSignal *signal = [RACSubject createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"muti"];
        return nil;
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"1%@",x);
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"2%@",x);
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"3%@",x);
    }];
}

- (IBAction)singleSend:(id)sender {
    RACSignal *signal = [RACSubject createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"single"];
        return nil;
    }];
    RACMulticastConnection *connection = [signal publish];
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"1%@",x);
    }];
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"2%@",x);
    }];
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"3%@",x);
    }];
    [connection connect];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
