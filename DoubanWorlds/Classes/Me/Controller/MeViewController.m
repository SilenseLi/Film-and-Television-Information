//
//  MeViewController.m
//  DoubanWorlds
//
//  Created by LYoung on 15/12/22.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import "MeViewController.h"
#import "BLRColorComponents.h"
#import "UIImage+ImageEffects.h"
#import "OAuthViewController.h"
#import "AccountTool.h"
#import "MeHttpTool.h"
#import "LoginViewController.h"
#import "UserInfos.h"

@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *expandZoomImageView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UserInfos * data;
@end

@implementation MeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [MeHttpTool userInfoSuccess:^(UserInfos *user) {
    }];
    self.data = [UserInfos sharedUserInfo];
    
    [self initTableView];
    
    [_expandZoomImageView sd_setImageWithURL:[NSURL URLWithString:self.data.large_avatar]];
}

- (void)initTableView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem * loginButton = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleBordered target:self action:@selector(loginActionClick:)];
    loginButton.tintColor = RGB_COLOR(0, 172, 0);
    self.navigationItem.rightBarButtonItem = loginButton;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(ZERO, KActivityDetailHeadH-80, SCREEN_WIDTH, SCREEN_HEIGHT )];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    _expandZoomImageView = [[UIImageView alloc] init];
    _expandZoomImageView.frame = CGRectMake((SCREEN_WIDTH-80)/2, (KActivityDetailHeadH-80)/2, 80, 80);
    _expandZoomImageView.layer.masksToBounds = YES;
    _expandZoomImageView.layer.cornerRadius = 40.f;
    _expandZoomImageView.userInteractionEnabled = YES;
    _expandZoomImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview: _expandZoomImageView];
}

- (void)loginActionClick:(UIBarButtonItem *)button{
    LoginViewController * loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndertifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndertifer];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"昵称   %@",self.data.name];
            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"简介   %@",self.data.desc];
            break;
        case 2:
            if (![self.data.is_banned boolValue]) {
                cell.textLabel.text = @"性别   男";
            } else {
                cell.textLabel.text = @"性别   女";
            }
            break;
        case 3:
            cell.textLabel.text = [NSString stringWithFormat:@"城市   %@",self.data.loc_name];
            break;
        default:
            cell.textLabel.text = [NSString stringWithFormat:@"时间   %@",self.data.created];
            break;
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -KActivityDetailHeadH ) {
        CGRect f = _expandZoomImageView.frame;
        f.origin.y = yOffset - 20;
        f.size.height =  -yOffset + 20;
        _expandZoomImageView.frame = f;
    }
}

-(void)dealloc{
    _tableView.delegate = nil;
}

@end
