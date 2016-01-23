//
//  ZLBBigWordsDetailViewController.m
//  WALK_HOURSE_LIGHT
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZLBBigWordsDetailViewController.h"
#import "ZLBMineText.h"
#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height
@interface ZLBBigWordsDetailViewController ()
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) UILabel *scrollLabel;
@property(nonatomic,strong)UIImageView *imageView;
@property (nonatomic, assign) NSInteger labelLength;
//@property (nonatomic, strong) ZLBMineText *scrollLabel;
@end

@implementation ZLBBigWordsDetailViewController

- (UILabel *)scrollLabel {
    if(_scrollLabel == nil) {
        _scrollLabel = [[UILabel alloc] init];
        
        //这里需要计算 label 的长度
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
        attributes[NSFontAttributeName] = [UIFont systemFontOfSize:160 weight:20];
       
        //求出一个合理的大小, xy 永远为0
        CGRect rects = [self.string boundingRectWithSize:CGSizeMake(100000000, 320) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        self.labelLength = rects.size.width;
        
        int labelWidth = rects.size.width;
        int labelHeight = rects.size.height;
        
        //设置 lable 的 frame
        CGRect frame = CGRectMake(HEIGHT, (WIDTH - labelHeight) / 2, labelWidth, labelHeight);
       _scrollLabel.frame = frame;
         NSLog(@"gjhghj%f",_scrollLabel.frame.origin.y);
        _scrollLabel.font = [UIFont systemFontOfSize:160 weight:20];
        [self.view addSubview:_scrollLabel];
        _scrollLabel.text = self.string;
        //只允许一行
        _scrollLabel.numberOfLines = 1;
        //加入有需要,让 scrollLable 自动更行内部控件
        [_scrollLabel layoutIfNeeded];
    }
    return _scrollLabel;
}
- (UIButton *)backBtn {
    if(_backBtn == nil) {
        _backBtn = [[UIButton alloc] init];
        _backBtn.backgroundColor = [UIColor yellowColor];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.frame = CGRectMake(0, 60, 40, 40);
        [self.view addSubview:_backBtn];
    }
    return _backBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.backBtn.hidden = NO;
    self.scrollLabel.hidden = NO;
    self.imageView.hidden = NO;
    
    [self changeOrientation];

}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
  
  
//设置时间,持续时间是根据字体的长度设定的
     NSInteger time ;
    if (self.labelLength <= 800) {
        time = 5;
    }else{
        time = (self.labelLength - 800) / 400 + 5;
    }
        [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionRepeat animations:^{
            CGRect frame = CGRectMake(0 - self.labelLength + 20, (WIDTH - self.scrollLabel.frame.size.height) / 2, self.scrollLabel.bounds.size.width, self.scrollLabel.bounds.size.height);
             self.scrollLabel.frame = frame;
             [self.scrollLabel layoutIfNeeded];
    
        } completion:^(BOOL finished) {
        }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void)btnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)changeOrientation{
    //设置我们的 view 的中心点
    //更具当前电池条的方向 获取需要旋转的角度的大小
//    if (orientation == UIInterfaceOrientationLandscapeLeft) {
//        
//        return CGAffineTransformMakeRotation(M_PI*1.5);
//        
//    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
//        
//        return CGAffineTransformMakeRotation(M_PI/2);
//        
//    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
//        
//        return CGAffineTransformMakeRotation(-M_PI);
//        
//    } else {
//        
//        return CGAffineTransformIdentity;
//        
//    }
    
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;//（获取当前电池条动画改变的时间）
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:duration];
    
    self.view.transform = CGAffineTransformRotate(self.view.transform, (M_PI/2));
    //在这里设置view.transform需要匹配的旋转角度的大小就可以了。
    [UIView commitAnimations];
    
}

//-(BOOL)shouldAutorotate{
//    return NO;
//}



@end




















