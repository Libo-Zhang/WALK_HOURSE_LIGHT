//
//  ZLBColorTableViewController.h
//  WALK_HOURSE_LIGHT
//
//  Created by tarena on 16/1/24.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^colorBlock) (UIColor *color,NSString *colorStr);
@interface ZLBColorTableViewController : UITableViewController

@property (nonatomic, strong) colorBlock block;
@end
