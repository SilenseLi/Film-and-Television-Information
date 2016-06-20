//
//  MovieDetailController.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/5.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "MovieDetailController.h"
#import "BLRColorComponents.h"
#import "UIImage+ImageEffects.h"
#import "UIBarButtonItem+Extension.h"
#import "TranslucentNavbar.h"
#import "AvatarsModel.h"
#import "MovieDetailHeadView.h"
#import "MovieHttpTool.h"
#import "MovieDetailIntroCell.h"

#import "UMSocial.h"

@interface MovieDetailController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>
{
    TranslucentNavbar *_navgationBar;
    MovieDetailHeadView *_headView;
    DetailMovieModel *_deatilMovieModel;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *expandZoomImageView;

@end

@implementation MovieDetailController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    //待更新
    
    [self initTableView];
    
    [self setupNavgationbar];
    
    [self requestData];
    
}

#pragma mark - 数据请求
- (void)requestData{
    [MovieHttpTool getMovieInfoWithID:_movieModel.ID movieInfoBlock:^(DetailMovieModel *movieModel) {
        _headView.infoModel = movieModel;
        _deatilMovieModel = movieModel;

//        [self initTableView];
        [self.tableView reloadData];
    }];
}

#pragma mark - 创建导航栏
- (void)setupNavgationbar{    
    _navgationBar = [[TranslucentNavbar alloc] init];
    _navgationBar.barHidden = YES;
    _navgationBar.title = _movieModel.title;
    _navgationBar.orgTitle = _movieModel.original_title;
    [self.view addSubview:_navgationBar];
    
    //分享按钮
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(SCREEN_WIDTH-60, 20, 50, 44);
    [shareBtn setImage:[UIImage imageNamed:@"mini_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navgationBar addSubview:shareBtn];
}

#pragma mark - 分享按钮点击事件
- (void)shareClick:(UIButton *)sender{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:APPKey
                                      shareText:[NSString stringWithFormat:@"UMSocial"]
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,nil]
                                       delegate:self];
}

#pragma mark - UITableView初始化
- (void)initTableView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT )];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.contentInset = UIEdgeInsetsMake(KMovieDetailHeadH, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    _expandZoomImageView = [[UIImageView alloc] init];
    _expandZoomImageView.frame = CGRectMake(0, -KMovieDetailHeadH, SCREEN_WIDTH, KMovieDetailHeadH);
    _expandZoomImageView.userInteractionEnabled = YES;
    _expandZoomImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_tableView addSubview: _expandZoomImageView];
    
    UIColor *tintColor = [BLRColorComponents darkEffect].tintColor;
        NSURL *imgURL = [NSURL URLWithString:_movieModel.images.medium];
    
        [[SDWebImageManager sharedManager] downloadImageWithURL:imgURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
            //处理下载进度
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [_expandZoomImageView setImage:[image applyBlurWithCrop:CGRectMake(0, 0, SCREEN_HEIGHT, KMovieDetailHeadH) resize:CGSizeMake(SCREEN_WIDTH, KMovieDetailHeadH) blurRadius:[BLRColorComponents darkEffect].radius tintColor:tintColor saturationDeltaFactor:[BLRColorComponents darkEffect].saturationDeltaFactor maskImage:nil]];
        }];
    
    
    
    _headView = [[MovieDetailHeadView alloc] init];
    _headView.frame = CGRectMake(0, -KMovieDetailHeadH , SCREEN_WIDTH, KMovieDetailHeadH );
    _headView.model = _movieModel;
    [_tableView addSubview: _headView];

}

#pragma mark - UItableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [MovieDetailIntroCell heightWithModel:_deatilMovieModel];
    }else{
        return 80;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        MovieDetailIntroCell *introCell = [MovieDetailIntroCell cellWithTableView:tableView];
        introCell.indexPath = indexPath;
        introCell.block = ^(NSIndexPath *path) {
            [tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        };
        [introCell configCellWithModel:_deatilMovieModel];
        return introCell;
    }else{
        static NSString *cellIndertifer = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndertifer];
        }
        cell.textLabel.text = @"测试数据====";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//停止滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -KMovieDetailHeadH ) {
        CGRect f = _expandZoomImageView.frame;
        f.origin.y = yOffset - 20;
        f.size.height =  -yOffset + 20;
        _expandZoomImageView.frame = f;
    }
    
    CGFloat offset = KMovieDetailHeadH - 20;
    if (yOffset > -offset) {//取消隐藏
        _navgationBar.barHidden = NO;
    }else{//隐藏
        _navgationBar.barHidden = YES;
    }
}

- (void)dealloc{
    _tableView.delegate = nil;
}

@end
