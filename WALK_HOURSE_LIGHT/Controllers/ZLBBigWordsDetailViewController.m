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
@property (nonatomic, strong) UIButton *scrollBtn;
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) UILabel *scrollLabel;
@property(nonatomic,strong)UIImageView *imageView;
@property (nonatomic, assign) NSInteger labelLength;
//@property (nonatomic, strong) ZLBMineText *scrollLabel;
@end

@implementation ZLBBigWordsDetailViewController
//scrollLabel 的懒加载
- (UILabel *)scrollLabel {
    if(_scrollLabel == nil) {
        _scrollLabel = [[UILabel alloc] init];
        
        //这里需要计算 label 的长度
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        //attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
        attributes[NSFontAttributeName] = [UIFont systemFontOfSize:self.labelSize weight:20];
       
        //求出一个合理的大小, xy 永远为0  这里是 viewDidLoad中生成的   后面面滚动点击方法中的是不一样的...
        CGRect rects = [self.string boundingRectWithSize:CGSizeMake(HEIGHT - 100, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        self.labelLength = rects.size.width;
        
        float labelWidth = rects.size.width;
        float labelHeight = rects.size.height;
        
        //设置 lable 的 frame
        CGRect frame = CGRectMake(70, 20, labelWidth, labelHeight);
         _scrollLabel.frame = frame;
        _scrollLabel.textColor = [UIColor redColor];

        _scrollLabel.font = [UIFont systemFontOfSize:self.labelSize weight:20];
        [self.view addSubview:_scrollLabel];
        _scrollLabel.text = self.string;
        //允许很多行
        _scrollLabel.numberOfLines = 0;
    }
    return _scrollLabel;
}
//滚动按钮懒加载
- (UIButton *)scrollBtn {
    if(_scrollBtn == nil) {
        //得到重新画好的 圆的 图片
         UIImage *image = [self drawPic];
        _scrollBtn = [[UIButton alloc] init];
   
        [_scrollBtn setTitle:@"滚动" forState:UIControlStateNormal];
        [_scrollBtn setBackgroundImage:image forState:UIControlStateNormal];
        [_scrollBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_scrollBtn addTarget:self action:@selector(scrollBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _scrollBtn.frame = CGRectMake(HEIGHT - 40, 60, 40, 40);
        [self.view addSubview:_scrollBtn];
    }
    return _scrollBtn;
}
//返回按钮懒加载
- (UIButton *)backBtn {
    if(_backBtn == nil) {
              //得到重新画好的 圆的 图片
        UIImage *image = [self drawPic];
        _backBtn = [[UIButton alloc] init];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backBtn setBackgroundImage:image forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.frame = CGRectMake(0, 60, 40, 40);
        [self.view addSubview:_backBtn];
    }
    return _backBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];
    self.backBtn.hidden = NO;
    self.scrollLabel.hidden = NO;
    self.imageView.hidden = NO;
    self.scrollBtn.hidden = NO;
    self.scrollLabel.textColor = self.labelColor;
   

}
#pragma mark - 隐藏电池栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}
#pragma mark - viewWillAppear
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self changeOrientation];
    if (self.isLoop) {
        [self scrollStraight];
        self.scrollBtn.enabled = NO;
    }else{
        
    }
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - 返回按钮响应
-(void)btnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -直接播放 view 不一样
-(void)scrollStraight{
    //这里需要计算 label 的长度
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:self.labelSize weight:20];
    
    //求出一个合理的大小, xy 永远为0
    CGRect rects = [self.string boundingRectWithSize:CGSizeMake(100000000, WIDTH) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    self.labelLength = rects.size.width;
    
    float labelWidth = rects.size.width;
    float labelHeight = rects.size.height;
    
    //设置 lable 的 frame
    CGRect frame = CGRectMake(HEIGHT, (WIDTH - labelHeight) / 2, labelWidth, labelHeight);
    _scrollLabel.frame = frame;
    
    _scrollLabel.font = [UIFont systemFontOfSize:self.labelSize weight:20];
    [self.view addSubview:_scrollLabel];
    _scrollLabel.text = self.string;
    //只允许一行
    _scrollLabel.numberOfLines = 1;
    //加入有需要,让 scrollLable 自动更行内部控件
    [_scrollLabel layoutIfNeeded];
    
    
    
    //设置时间,持续时间是根据字体的长度设定的
    NSInteger time ;
    if (self.labelLength <= 800) {
        time = 5;
    }else{
        time = (self.labelLength - 800) / 400 + 5;
    }
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionRepeat animations:^{
        CGRect frame = CGRectMake(0 - self.labelLength, (WIDTH - self.scrollLabel.frame.size.height) / 2, self.scrollLabel.bounds.size.width, self.scrollLabel.bounds.size.height);
        self.scrollLabel.frame = frame;
        [self.scrollLabel layoutIfNeeded];
        
    } completion:^(BOOL finished) {
    }];
    
    
}
#pragma mark - 滚动按钮 响应
-(void)scrollBtnClick{
    
    //这里需要计算 label 的长度
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
   // attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:self.labelSize weight:20];
    
    //求出一个合理的大小, xy 永远为0
    CGRect rects = [self.string boundingRectWithSize:CGSizeMake(100000000, HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    self.labelLength = rects.size.width;
    
    float labelWidth = rects.size.width;
    float labelHeight = rects.size.height;
    
    //设置 lable 的 frame
    CGRect frame = CGRectMake(WIDTH, (HEIGHT - labelHeight) / 2, labelWidth, labelHeight);
    _scrollLabel.frame = frame;
    
    _scrollLabel.font = [UIFont systemFontOfSize:self.labelSize weight:20];
    [self.view addSubview:_scrollLabel];
    _scrollLabel.text = self.string;
    //只允许一行
    _scrollLabel.numberOfLines = 1;
    //加入有需要,让 scrollLable 自动更行内部控件
    [_scrollLabel layoutIfNeeded];
    [self changeLableToScroll];
    self.scrollBtn.enabled = NO;
    
}
#pragma mark - 使view 旋转90度
-(void)changeOrientation{
 
    [UIView animateKeyframesWithDuration:0.8 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        self.view.transform = CGAffineTransformRotate(self.view.transform, (M_PI/2));
    } completion:nil];
    
}
#pragma mark - 使字体滚动 的具体实现
-(void)changeLableToScroll{
    
    //设置时间,持续时间是根据字体的长度设定的
    NSInteger time ;
    if (self.labelLength <= 800) {
        time = 5;
    }else{
        time = (self.labelLength - 800) / 400 + 5;
    }
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionRepeat animations:^{
        CGRect frame = CGRectMake(0 - self.labelLength, (HEIGHT - self.scrollLabel.frame.size.height) / 2, self.scrollLabel.bounds.size.width, self.scrollLabel.bounds.size.height);
        self.scrollLabel.frame = frame;
        [self.scrollLabel layoutIfNeeded];
        
    } completion:^(BOOL finished) {
    }];

    
}
#pragma mark - 画图 背景图片变圆
-(UIImage *)drawPic{
    UIGraphicsBeginImageContext(CGSizeMake(200, 200));
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 200)];
    [path addClip];
    //绘制原图
    UIImage *image = [UIImage imageNamed:@"delete_btn"];
    [image drawInRect:CGRectMake(0, 0, 200, 200)];
 
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}




@end






















