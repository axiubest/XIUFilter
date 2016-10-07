//
//  XIUImageMainButton.m
//  CoreImage滤镜
//
//  Created by A-XIU on 16/9/8.
//  Copyright © 2016年 XIU. All rights reserved.
//

#import "XIUImageMainButton.h"

@implementation XIUImageMainButton

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpButton];
    }
    return self;
}

- (void)setUpButton {
    /**************** top lab ****************/
    _lab = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height * 0.2)];
    _lab.textAlignment = 1;
    _lab.text = @"model send";
    [self addSubview:_lab];
    
/****************buttom image ****************/
    
    _img = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + _lab.frame.size.height, self.frame.size.width, self.frame.size.height * 0.8)];
    _img.backgroundColor = [UIColor orangeColor];
    [self addSubview:_img];
}
@end
