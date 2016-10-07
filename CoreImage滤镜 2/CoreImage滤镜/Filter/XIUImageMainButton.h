//
//  XIUImageMainButton.h
//  CoreImage滤镜
//
//  Created by A-XIU on 16/9/8.
//  Copyright © 2016年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XIU_FiterImageModel.h"
@interface XIUImageMainButton : UIButton
@property (nonatomic, strong) UILabel *lab;
@property (nonatomic, strong) UIImageView *img;

-(instancetype)initWithFrame:(CGRect)frame;

@end
