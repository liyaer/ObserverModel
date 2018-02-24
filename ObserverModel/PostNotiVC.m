//
//  PostNotiVC.m
//  ObserverModel
//
//  Created by 杜文亮 on 2017/9/23.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "PostNotiVC.h"

@interface PostNotiVC ()

@end

@implementation PostNotiVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)postNoti:(id)sender
{
     //object就是要传的值，一次只能传一个值。可以通过userInfo来实现多个参数的传值使用。
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notiOne" object:nil userInfo:@{@"notiKey":@"发送通知时携带的参数"}];
}


@end
