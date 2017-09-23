//
//  ViewController.m
//  ObserverModel
//
//  Created by 杜文亮 on 2017/9/23.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "ViewController.h"
#import "NotiTwoVC.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *showKVOLab;

@property (weak, nonatomic) IBOutlet UILabel *showNoti;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     *   KVO：只要添加监听的控制器（或者说类）未被释放，那么无论“何时何地”改变了属性值，都可以监听到（看下面KVO 1，2的例子，经常用于监听模型中某个属性值的变化，这里就不在举例，本质一样的）
     
     *   通知：一般两个或者多个不同的类之间的通信（对于一个类即是通知的发送者，又是通知的接受者，这样做是毫无意义的，类的内部无需这样的方式进行通信，都可以直接通信）。注意我用的是“类”，通知不仅仅只能用在控制器（控制器也可以看做一个类）中，也可以用在其他类中（比如自定义的Cell等等）
     */
    
    self.showKVOLab.text = @"点击上方Btn查看效果";
    [self.showKVOLab addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew || NSKeyValueChangeOldKey context:nil];//1，KVO，本页面修改属性值，监测到变化（基本很少用）
    
    self.showNoti.text = @"收到通知前";
    [self.showNoti addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew || NSKeyValueChangeOldKey context:nil];//2，KVO，其他页面修改属性值，监测到变化（常用）
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotiHandle:) name:@"notiOne" object:nil];//通知
}




#pragma mark - KVO

- (IBAction)getKVOHandle:(id)sender
{
    self.showKVOLab.text = @"更改属性值，测试KVO";
}

//一旦属性被操作了，这里会自动响应（上面设置观察的属性才会在这响应）
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"text"])
    {
        NSLog(@"KVO 生效\n旧值：%@\n新值：%@",change[@"old"],change[@"new"]);
    }
}




#pragma mark - 通知

-(void)getNotiHandle:(NSNotification *)noti
{
    if ([noti.name isEqualToString:@"notiOne"])
    {
        self.showNoti.text = [NSString stringWithFormat:@"收到通知后：%@",noti.userInfo];
    }
}




#pragma mark - dealloc

-(void)dealloc
{
    [self.showKVOLab removeObserver:self forKeyPath:@"text"];//KVO不释放会crash
    [self.showNoti removeObserver:self forKeyPath:@"text"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s dealloc",__FUNCTION__);
}




#pragma mark - 这部分是通知的测试代码：测试控制器即使已经初始化，但是未出现在屏幕上，此时通知是不起作用的

- (IBAction)testNotiTwo:(id)sender
{
    NotiTwoVC *vc = [[NotiTwoVC alloc] init];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
   {
       [[NSNotificationCenter defaultCenter] postNotificationName:@"notiTwo" object:nil];
   });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
    {
        [self.navigationController pushViewController:vc animated:YES];
    });
}


@end
