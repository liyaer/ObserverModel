//
//  NotiTwoVC.m
//  ObserverModel
//
//  Created by 杜文亮 on 2017/9/23.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "NotiTwoVC.h"

@interface NotiTwoVC ()
{
    UILabel *label;
}
@end

@implementation NotiTwoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    label.text = @"收到通知前";
    [self.view addSubview:label];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotiTwoHandle) name:@"notiTwo" object:nil];
}

-(void)getNotiTwoHandle
{
    label.text = @"sdkfjkasjfksjfksdjfksfs";
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s dealloc",__FUNCTION__);
}

@end
