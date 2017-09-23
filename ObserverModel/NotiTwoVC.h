//
//  NotiTwoVC.h
//  ObserverModel
//
//  Created by 杜文亮 on 2017/9/23.
//  Copyright © 2017年 杜文亮. All rights reserved.
//


/*
 *                              该部分是测试代码
 
 *  正常使用通知的情况：接收通知的VC出现在屏幕上一次（初始化完成，并且在屏幕上显示过一次，即使当前正在显示的不是此VC），并且VC未dealloc。此时该VC可以接收到下级控制器发送的通知消息。【ViewController】和【PostNotiVC】中是正常的使用情况，下级控制器发送通知，上级或者上多级控制器监听通知。
 
 *  该部分测试代码，测试控制器即使已经初始化，但是未出现在屏幕上，此时通知是不起作用的。【ViewController】和【NotiTwoVC】是描述这种情况，上级控制器发送通知，下级控制器监听通知，是错误的做法，通知是不起作用的
 
 */

#import <UIKit/UIKit.h>

@interface NotiTwoVC : UIViewController

@end
