//
//  ViewController.m
//  HYScratchCardViewExample
//
//  Created by Shadow on 14-5-26.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "ViewController.h"
#import "HYScratchCardView.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()

@property (nonatomic, strong) HYScratchCardView *scratchCardView;

@end

@implementation ViewController

- (UIImage*)convertViewToImage:(UIView*)view{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    //    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (UIView *)getAwardsSuccesView {

    UIView *view = [[UIView alloc] init];
    view.frame = self.scratchCardView.frame;
    
    UIImageView *lottoBG = [[UIImageView alloc] initWithFrame:view.bounds];
    lottoBG.image = [UIImage imageNamed:@"yesBG"];
    [view addSubview:lottoBG];
    
    UILabel * moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(34, 20, 80, 30)];
    moneyLabel.text = @"50元";
    moneyLabel.textColor = [UIColor whiteColor];
    moneyLabel.font = [UIFont systemFontOfSize:18.0];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.backgroundColor = [UIColor clearColor];
    [view addSubview:moneyLabel];
    
    
    UILabel * couponTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(34, CGRectGetMaxY(moneyLabel.frame), 80, 18)];
    couponTextLabel.text = @"优惠券";
    couponTextLabel.textColor = [UIColor whiteColor];
    couponTextLabel.font = [UIFont systemFontOfSize:12.0];
    couponTextLabel.textAlignment = NSTextAlignmentCenter;
    couponTextLabel.backgroundColor = [UIColor clearColor];
    [view addSubview:couponTextLabel];
    
    
    UILabel * congratulationLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 14, 100, 30)];
    congratulationLabel.text = @"恭喜您";
    congratulationLabel.textColor = [UIColor redColor];
    congratulationLabel.font = [UIFont systemFontOfSize:18.0];
    congratulationLabel.backgroundColor = [UIColor clearColor];
    [view addSubview:congratulationLabel];

    
    UILabel * detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, CGRectGetMaxY(congratulationLabel.frame), 153, 30)];
    detailLabel.text = @"获得￥50优惠券,已放入“我的-我的优惠券”中";
    detailLabel.font = [UIFont systemFontOfSize:12.0];
    detailLabel.numberOfLines = 2;
    detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    detailLabel.backgroundColor = [UIColor clearColor];
    [view addSubview:detailLabel];
    
    return view;
}


- (UIView *)getAwardsFailView {

    UIView *view = [[UIView alloc] init];
    view.frame = self.scratchCardView.frame;
    
    UIImageView *ff = [[UIImageView alloc] initWithFrame:view.bounds];
    ff.image = [UIImage imageNamed:@"noBG"];
    [view addSubview:ff];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 20, 296, 30)];
    titleLabel.text = @"很遗憾";
    titleLabel.font = [UIFont systemFontOfSize:18.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    [view addSubview:titleLabel];
    
    UILabel * subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, CGRectGetMaxY(titleLabel.frame), 296, 18)];
    subTitleLabel.text = @"没有刮中喔，下次再接再厉吧~";
    subTitleLabel.font = [UIFont systemFontOfSize:14.0];
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    subTitleLabel.backgroundColor = [UIColor clearColor];
    [view addSubview:subTitleLabel];
    
    return view;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIImageView *lottoBG = [[UIImageView alloc] initWithFrame:CGRectMake(15, 100, 345, 110)];
    lottoBG.image = [UIImage imageNamed:@"background"];
    lottoBG.userInteractionEnabled = YES;
    [self.view addSubview:lottoBG];
    
    self.scratchCardView = [[HYScratchCardView alloc]initWithFrame:CGRectMake(10, 10, 325, 90)];
    
    int n = arc4random()%2;
    //NSLog(@"n= %d",n);
    if (n == 1) {
        self.scratchCardView.image = [self convertViewToImage:[self getAwardsSuccesView]];
    }else {
        self.scratchCardView.image = [self convertViewToImage:[self getAwardsFailView]];
    }
    
    [lottoBG addSubview:self.scratchCardView];
    
    self.scratchCardView.completion = ^(id userInfo) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"恭喜"
                                                           message:@"恭喜中奖."
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
        [alertView show];
    };
}


- (IBAction)resetButtonClick:(UIButton *)sender {
    [self.scratchCardView reset];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
