//
//  XIU_EditView.h
//  CoreImage滤镜
//
//  Created by XIUDeveloper on 16/9/8.
//  Copyright © 2016年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EditImageDelegate <NSObject>

- (void)ChangeImage:(UIImage *)img;

- (void)showSlider;
@end
@interface XIU_EditView : UIView

- (void)baseInit:(UIImage *)img;



@property (nonatomic, assign) id<EditImageDelegate> MyDelegate;

@end
