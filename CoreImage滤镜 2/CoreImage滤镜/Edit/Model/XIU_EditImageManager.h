//
//  XIU_EditImageManager.h
//  CoreImage滤镜
//
//  Created by XIUDeveloper on 16/9/10.
//  Copyright © 2016年 XIU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <UIKit/UIKit.h>

@protocol EditImageDelegate <NSObject>

- (void)changeImage:(UIImage *)image;

@end

@interface XIU_EditImageManager : NSObject

+(XIU_EditImageManager *)shareManager;

-(void)changeStaturation;
-(void)changeBrightness:(UISlider *)slider;
-(void)changeContrast:(UISlider *)slider;
@property (nonatomic,assign) id<EditImageDelegate> MyDelegate;

@end
