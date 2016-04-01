//
//  SecondViewController.m
//  MixDevelopment
//
//  Created by 李怀泰 on 16/3/25.
//  Copyright © 2016年 李怀泰. All rights reserved.
//

#import "SecondViewController.h"

#define SCR_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCR_HEIGHT [UIScreen mainScreen].bounds.size.height

//头视图的高度
#define HEADERHEIGHT 150
//头像的大小
#define IMAGEHIGHT   60

@interface SecondViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIImageView * iamgeView;
@property (nonatomic, strong) UIImageView * headImage;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;//tableView头视图的高度
@property (nonatomic, strong) NSArray * dataArray;

@end

@implementation SecondViewController

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 180, SCR_WIDTH, SCR_HEIGHT)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]init];
//        _tableView.tableHeaderView = [self createTableViewHeaderViewWithHeight:HEADERHEIGHT + IMAGEHIGHT / 2];
    }
    return _tableView;
}

-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"虽然活的像只狗，但我绝对不会吃💩", @"虽然活的像只狗，但我绝对不会吃💩", @"虽然活的像只狗，但我绝对不会吃💩"];
    }
    return _dataArray;
}

#pragma mark - lifeCycle

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"图片的拉伸动画";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    UIView * view = [self createTableViewHeaderViewWithHeight:180];
    [self.view addSubview:view];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark - image

-(UIImage *) createNewImage{
    UIImage * image = [UIImage imageNamed:@"dog"];
    
    CGFloat topC = image.size.height * 0.5;
    CGFloat leftC = image.size.width * 0.5;
    CGFloat bottomC = image.size.height * 0.5;
    CGFloat rightC = image.size.width * 0.5;
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(topC, leftC, bottomC, rightC);
    
    image = [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeTile];
    return image;
}

#pragma mark -tableViewHeaderView

-(UIView *) createTableViewHeaderViewWithHeight:(CGFloat) height{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCR_WIDTH, height)];
    
    _iamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    _iamgeView.image = [self createNewImage];
    [_headerView addSubview:_iamgeView];
    
    //添加毛玻璃效果
    UIBlurEffect * effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
    effectView.frame = _iamgeView.frame;
    effectView.alpha = 0.7;
    [_iamgeView addSubview:effectView];
    
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCR_WIDTH - 60) / 2, 120, 60, 60)];
    _headImage.layer.cornerRadius = 30;
    _headImage.layer.masksToBounds = YES;
    _headImage.image = [UIImage imageNamed:@"dogHead"];
    [_iamgeView addSubview:_headImage];
    
    return _headerView;
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y + 64;
    if (offsetY < 0) {
        CGFloat value = offsetY / 80;
        
        CGAffineTransform transform = CGAffineTransformMakeScale(1-value, 1-value);
        self.iamgeView.transform = CGAffineTransformTranslate(transform, 0, (1-value) * 0.5);
    }
}

@end
