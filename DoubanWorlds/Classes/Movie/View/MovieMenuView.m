//
//  MovieMenuView.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/4.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "MovieMenuView.h"

@interface MovieMenuView ()
{
    UIView *_bottomline;
}
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation MovieMenuView

-(instancetype)init{
    self = [super init];
    if (self) {
        _buttonArray = [[NSMutableArray alloc] init];

        
        
        [self addButtonTitle:@"正在热映" buttonIndex:0];
        [self addButtonTitle:@"即将上映" buttonIndex:1];
        
        _bottomline = [[UIView alloc] init];
        _bottomline.frame = CGRectMake(0, 43, (SCREEN_WIDTH/2), 2);
        _bottomline.backgroundColor = TheThemeColor;
        [self addSubview:_bottomline];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [AppTools colorWithHexString:@"#F0F0F0"];
        line.frame = CGRectMake(0, 44, SCREEN_WIDTH, 1);
        [self addSubview:line];
        

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kMovieMenuBtnClick:) name:kMovieScrollViewMove object:nil];

    }
    return self;
}
-(void)addButtonTitle:(NSString *)title buttonIndex:(int)buttonIndex{
    UIButton *oneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [oneBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [oneBtn setTitleColor:TheThemeColor forState:UIControlStateSelected];
    [oneBtn setTitle:title forState:UIControlStateNormal];
    [oneBtn setTitle:title forState:UIControlStateSelected];
    
    oneBtn.frame = CGRectMake((SCREEN_WIDTH/2)*buttonIndex, 0, (SCREEN_WIDTH/2), 45);
    [oneBtn addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    oneBtn.tag  = buttonIndex;
    if (buttonIndex == 0) {
        oneBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        oneBtn.selected = YES;
    }else{
        oneBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        oneBtn.selected = NO;
    }
    [self addSubview:oneBtn];
    [_buttonArray addObject:oneBtn];

}


#pragma mark - 按钮点击选择事件
-(void)selectButtonAction:(UIButton *)sender{
    
    int buttonTag = (int)sender.tag;
    
    //滑动动画
    [self bottomLineAnimationBtnIndex:buttonTag];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMovieMenuBtnClick object:nil userInfo:@{kMovieMenuBtnClick : [NSString stringWithFormat:@"%d",buttonTag]}];
    
}

-(void)kMovieMenuBtnClick:(NSNotification *)note{
    NSString *indexNum = note.userInfo[kMovieScrollViewMove];
    [self bottomLineAnimationBtnIndex:[indexNum intValue]];
}

#pragma mark - 滑动底部line动画
-(void)bottomLineAnimationBtnIndex:(int)btnIndex{
    UIButton *currentBtn=[_buttonArray objectAtIndex:btnIndex];
    
    //开启动画，移动下划线
    [UIView animateWithDuration:0.25 animations:^{
        _bottomline.left = currentBtn.left;
    }];
    
    for (UIButton *oneBtn in _buttonArray) {
        if (oneBtn.tag == btnIndex) {
            oneBtn.selected = YES;
        }else{
            oneBtn.selected = NO;
        }
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
