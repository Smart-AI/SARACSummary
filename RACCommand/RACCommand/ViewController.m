//
//  ViewController.m
//  RACCommand
//
//  Created by Smart-AI on 09/01/2018.
//  Copyright © 2018 Smart-AI. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)one:(id)sender {
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"input=%@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"发送数据"];
            return nil;
        }];
    }];
    RACSignal *signal = [command execute:@"执行命令"];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号=%@",x);
    }];
}

- (IBAction)two:(id)sender {
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"input=%@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"发送数据"];
            return nil;
        }];
    }];
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"信号=%@",x);
        }];
    }];
    [command execute:@"执行命令"];
}

- (IBAction)three:(id)sender {
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"input=%@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"发送数据"];
            return nil;
        }];
    }];
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号=%@",x);
    }];
    [command execute:@"执行命令"];
}

- (IBAction)four:(id)sender {
    RACSubject *signalOfSignals = [RACSubject subject];
    RACSubject *signalA = [RACSubject subject];
    [signalOfSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号=%@",x);
    }];
    [signalOfSignals sendNext:signalA];
    [signalA sendNext:@"发送数据"];
}

- (IBAction)five:(id)sender {
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"input=%@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"发送数据"];
            
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue] == YES) {
            NSLog(@"当前正在执行%@", x);
        } else {
            NSLog(@"执行完成/没有执行");
        }
    }];
    
    [command execute:@0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
