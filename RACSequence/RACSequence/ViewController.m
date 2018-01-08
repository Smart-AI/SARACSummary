//
//  ViewController.m
//  RACSequence
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

- (IBAction)loop:(id)sender {
    NSString *countryFile = [[NSBundle mainBundle] pathForResource:@"country.plist" ofType:nil];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:countryFile];
    
    [dictArray.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error=%@",error);
    } completed:^{
        NSLog(@"completed");
    }];
    
    
    
}

- (IBAction)macroLoop:(id)sender {
    NSDictionary *dict = @{@"key1":@"1", @"key2":@"2"};
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        NSString *key = x[0];
        NSString *value = x[1];
        NSLog(@"key=%@ value=%@",key,value);
        RACTupleUnpack(NSString *keys, NSString *values) = x;
        NSLog(@"keys=%@ values=%@",keys,values);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error=%@",error);
    } completed:^{
        NSLog(@"completed");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
