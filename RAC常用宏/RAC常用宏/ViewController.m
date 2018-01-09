//
//  ViewController.m
//  RAC常用宏
//
//  Created by Smart-AI on 09/01/2018.
//  Copyright © 2018 Smart-AI. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) RACSignal *signal;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self text3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)test {
    // RAC:把一个对象的某个属性绑定一个信号,只要发出信号,就会把信号的内容给对象的属性赋值
    // 给label的text属性绑定了文本框改变的信号
    RAC(self.label, text) = self.textField.rac_textSignal;
}

- (void)test2 {
    /**
     *  KVO
     *  RACObserve:快速的监听某个对象的某个属性改变
     *  返回的是一个信号,对象的某个属性改变的信号
     */
    [RACObserve(self.view, center) subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号=%@",x);
    }];
}

- (void)test1and2 {
    RAC(self.label, text) = self.textField.rac_textSignal;
    [RACObserve(self.label, text) subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号=%@",x);
    }];
}

/*
 * 快速包装一个元组
 * 把包装的类型放在宏的参数里面,就会自动包装
 */
- (void)text3 {
    RACTuple *tuple = RACTuplePack(@1,@2,@3);
    RACTupleUnpack(NSNumber *num1, NSNumber *num2, NSNumber *num3) = tuple;
    NSLog(@"%@ %@ %@", num1, num2, num3);
}

@end
