//
//  GViewController.m
//  GNetworking
//
//  Created by gexinwei on 09/07/2018.
//  Copyright (c) 2018 gexinwei. All rights reserved.
//

#import "GViewController.h"
#import <GNetworking/GNetworking-umbrella.h>

@interface GViewController ()

@end

@implementation GViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *abc = @"abc";
    NSLog(@"1=%@",abc);
    Byte iv[8] = {2,3,4,5,6,7,8};
    abc = [GDESModel encryptUse3DES:abc key:@"mddqkio9012345678901234567890123" iv:iv];
    NSLog(@"2=%@",abc);
    abc = [GDESModel decryptUse3DES:abc key:@"mddqkio9012345678901234567890123" iv:iv];
    NSLog(@"3=%@",abc);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
