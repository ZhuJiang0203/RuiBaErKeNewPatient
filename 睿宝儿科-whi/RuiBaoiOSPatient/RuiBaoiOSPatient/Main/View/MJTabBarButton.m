//
//  MJTabBarButton.m
//  00-ItcastLottery
//
//  Created by gkchun－mac on 14-4-15.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJTabBarButton.h"

@interface MJTabBarButton ()

@property (nonatomic, strong) UILabel *unreadLabeld;

@end

@implementation MJTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self.imageView sizeToFit];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        

        UILabel *unread = [[UILabel alloc] init];
        unread.font = [UIFont systemFontOfSize:12];
        unread.textAlignment = NSTextAlignmentCenter;
        unread.textColor = [UIColor whiteColor];
        unread.backgroundColor = [UIColor redColor];
        unread.layer.cornerRadius = 9;
        unread.clipsToBounds = YES;
        unread.hidden = YES;
        [self addSubview:unread];
        self.unreadLabeld = unread;
        
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
//        line.backgroundColor = [UIColor blueColor]; //[UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1.0];
//        [self addSubview:line];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat centerX = self.frame.size.width/2;
    CGFloat centerY = 21;
    self.imageView.center = CGPointMake(centerX, centerY);
    CGFloat titleH = 14;
    CGFloat titleY = self.frame.size.height - titleH;
    CGFloat titleW = self.frame.size.width;
    self.titleLabel.frame = CGRectMake(0, titleY, titleW, titleH);
    
    self.unreadLabeld.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) - 6, 3, 18, 18);
}

- (void)setUnread:(NSString *)unread {
    
    int unreadInt = [unread intValue];
    
    if (unreadInt < 1) {
        self.unreadLabeld.hidden = YES;
    } else {
        self.unreadLabeld.hidden = NO;
        CGRect rect = self.frame;
        if (unreadInt < 10) {
            rect.size.width = 18;
            self.unreadLabeld.text = [NSString stringWithFormat:@"%d", unreadInt];
        } else if (unreadInt < 100) {
            rect.size.width = 28;
            self.unreadLabeld.text = [NSString stringWithFormat:@"%d", unreadInt];
        } else {
            rect.size.width = 18;
            self.unreadLabeld.text = @"···";
        }
        self.frame = rect;
    }
}

/**
 *  重写highlighted方法
 */
- (void)setHighlighted:(BOOL)highlighted {}

@end
