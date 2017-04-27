//
//  SecondViewController.m
//  KeyChain
//
//  Created by 三维度 on 2017/4/6.
//  Copyright © 2017年 三维度. All rights reserved.
//

#import "SecondViewController.h"
#import "XKeyChain.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UITextField *payTextfield;

@end

static NSString *const SEC_PASSWOTD = @"demo.xzr.KeyChain.sec"; //存取钥匙串具体业务的键值

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"密码登录";
    
    NSString *informationStr = (NSString *)[XKeyChain loadDataKey:SEC_PASSWOTD];
    _payTextfield.text = informationStr;
    NSLog(@"%@",informationStr);
}

- (IBAction)saveData:(id)sender {
    
    [XKeyChain saveData:_payTextfield.text key:SEC_PASSWOTD];
}

- (IBAction)delete:(id)sender {
    
    [XKeyChain deleteData];
}


@end
