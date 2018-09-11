//
//  GViewController.m
//  GNetworking
//
//  Created by gexinwei on 09/07/2018.
//  Copyright (c) 2018 gexinwei. All rights reserved.
//

#import "GViewController.h"
#import "MDDNetConfig.h"

@interface GViewController ()

@end

@implementation GViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *abc = @"abc";
    NSLog(@"1=%@",abc);
    abc = [GDESModel encryptUse3DES:abc key:@"mddqkio9012345678901234567890123" iv:@"23456789"];
    NSLog(@"2=%@",abc);
    abc = [GDESModel decryptUse3DES:abc key:@"mddqkio9012345678901234567890123" iv:@"23456789"];
    NSLog(@"3=%@",abc);
    
    [GViewController userLogin:@"15062212900" pwd:@"123456" success:^(NSDictionary *response) {
        
    } failure:^(NSError *error) {
        
    } ];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 用户登录
 
 @param phone 手机号
 @param pwd 密码
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)userLogin:(NSString *)phone
              pwd:(NSString *)pwd
          success:(void (^) (NSDictionary *response))success
          failure:(void (^) (NSError *error))failure {
    
    NSDictionary *param = @{@"phone":phone,
                            @"pwd":pwd,
                            @"action":@"login"
                            };
    param = [MDDNetConfig finalParam:param];
    NSString *url = @"http://mdd.apps365home.com/mdd_api.php";
    [GNetworkingManager POST:url param:param success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
