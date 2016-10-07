//
//  XIU_FiterView.h
//  CoreImage滤镜
//
//  Created by A-XIU on 16/9/8.
//  Copyright © 2016年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FiterImageDelegate <NSObject>

- (void)ChangeImage:(UIImage *)img;

@end

@interface XIU_FiterView : UIView

- (void)baseInit:(UIImage *)img;
@property (nonatomic, assign) id<FiterImageDelegate> MyDelegate;
@end
