//
//  ZLBMineText.m
//  WALK_HOURSE_LIGHT
//
//  Created by tarena on 16/1/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZLBMineText.h"

@implementation ZLBMineText


- (void)drawRect:(CGRect)rect {
    self.size = 50;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attributes[NSFontAttributeName] = [UIFont italicSystemFontOfSize:self.size];
    //求出一个合理的大小, xy 永远为0
    CGRect rects = [self.str boundingRectWithSize:CGSizeMake(999, 320) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    [self.str drawInRect:rects withAttributes:attributes];
    
    
}


@end
