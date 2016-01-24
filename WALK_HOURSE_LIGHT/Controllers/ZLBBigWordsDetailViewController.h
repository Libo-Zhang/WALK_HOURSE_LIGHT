//
//  ZLBBigWordsDetailViewController.h
//  WALK_HOURSE_LIGHT
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLBBigWordsDetailViewController : UIViewController
@property (nonatomic, strong) NSString *string;
@property (nonatomic, assign) NSInteger labelSize;
@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic, assign) BOOL isLoop;
@end
