//
//  NewViewController.m
//  MixDevelopment
//
//  Created by 李怀泰 on 16/3/25.
//  Copyright © 2016年 李怀泰. All rights reserved.
//

#import "NewViewController.h"

@implementation NewViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"图片";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    NSString * string = @"离离原上草，一岁一枯荣。\n野火烧不尽，春风吹又生。";
    CGSize size = [string boundingRectWithSize:CGSizeMake(INT32_MAX, INT32_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    
    NSLog(@"%f, %f, %d, %f", width - 200, size.width, INT32_MIN, size.height);
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[self createNewImage] forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    button.frame = CGRectMake(100, 100, size.width + 20, size.height + 20);
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:string forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.titleLabel.numberOfLines = 0;
    [self.view addSubview:button];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
}

-(UIImage *)createNewImage{
    UIImage * image = [UIImage imageNamed:@"iconfont-liaotian"];
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    image = [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeTile];
    return image;
    
}

@end

