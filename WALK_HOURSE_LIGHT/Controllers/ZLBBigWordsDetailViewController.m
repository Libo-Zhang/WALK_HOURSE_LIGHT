//
//  ZLBBigWordsDetailViewController.m
//  WALK_HOURSE_LIGHT
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZLBBigWordsDetailViewController.h"
#import "Masonry.h"
@interface ZLBBigWordsDetailViewController ()
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) UILabel *scrollLabel;
@end

@implementation ZLBBigWordsDetailViewController
- (UILabel *)scrollLabel {
    if(_scrollLabel == nil) {
        _scrollLabel = [[UILabel alloc] init];
        _scrollLabel.frame = CGRectMake(-30, 50, 100, 200);
        _scrollLabel.text = self.string;
        [self.view addSubview:_scrollLabel];
    }
    return _scrollLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.backBtn.hidden = NO;
    self.scrollLabel.hidden = NO;

//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(change) userInfo:nil repeats:YES];
     //CGRect frame = self.scrollLabel.frame;
    [UIView animateWithDuration:5 animations:^{
        CGRect frame = CGRectMake(350, 50, 100, 200) ;
        //frame.origin.x = 350;
        self.scrollLabel.frame = frame;
        
    }];
//    [UIView beginAnimations:@"testAnimation" context:NULL];
//    [UIView setAnimationDuration:8.8f];
//    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationRepeatAutoreverses:NO];
//    [UIView setAnimationRepeatCount:999999];
//    
//    frame = self.scrollLabel.frame;
//    frame.origin.x = 350;
//    self.scrollLabel.frame = frame;
//    [UIView commitAnimations];
}
-(void)change{
    CGRect frame = self.scrollLabel.frame;
    frame.origin.x = 350;
    self.scrollLabel.frame = frame;
    [self.scrollLabel layoutIfNeeded];
    
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UIButton *)backBtn {
	if(_backBtn == nil) {
		_backBtn = [[UIButton alloc] init];
        _backBtn.backgroundColor = [UIColor yellowColor];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backBtn];
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60);
            make.left.mas_equalTo(0);
        }];

	}
	return _backBtn;
}
-(void)btnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
