//
//  FirstViewController.m
//  KeyChain
//
//  Created by 三维度 on 2017/4/6.
//  Copyright © 2017年 三维度. All rights reserved.
//

#import "FirstViewController.h"
#import "XKeyChain.h"
#import "SecondViewController.h"

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@end

static NSString *const FIR_PASSWORD = @"demo.xzr.KeyChain.fir"; //存取钥匙串具体业务的键值
@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"验证码登录";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一页"style:UIBarButtonItemStylePlain target:self action:@selector(nextPage)];
    
    NSString *informationStr = (NSString *)[XKeyChain loadDataKey:FIR_PASSWORD];
    _passWordTextField.text = informationStr;
    NSLog(@"%@",informationStr);
}

/**
 删除存在钥匙串中该APP的所有信息
 
 @param sender 按钮
 */
- (IBAction)deleteAllData:(id)sender {
    
    [XKeyChain deleteData];
}

/**
 保存键对应的信息

 @param sender 按钮
 */
- (IBAction)saveData:(id)sender {
    
    [XKeyChain saveData:_passWordTextField.text key:FIR_PASSWORD];
}

- (void)nextPage {
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}
@end
