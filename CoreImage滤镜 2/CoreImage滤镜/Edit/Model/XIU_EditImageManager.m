//
//  XIU_EditImageManager.m
//  CoreImage滤镜
//
//  Created by XIUDeveloper on 16/9/10.
//  Copyright © 2016年 XIU. All rights reserved.
//

#import "XIU_EditImageManager.h"
static XIU_EditImageManager *mgr = nil;

@interface XIU_EditImageManager ()
{
    CIContext *_context;//Core Image上下文
    CIImage *_image;//我们要编辑的图像
    CIImage *_outputImage;//处理后的图像
    CIFilter *_colorControlsFilter;//色
}

@end

@implementation XIU_EditImageManager

+ (XIU_EditImageManager *)shareManager {
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        mgr = [[XIU_EditImageManager alloc] init];
    });
    return mgr;
}

-(instancetype)init {
    self = [super init];
    if (self) {
      _context = [CIContext contextWithOptions:nil];
        //取得滤镜
        _colorControlsFilter=[CIFilter filterWithName:@"CIColorControls"];
  
    }
    return self;
}


#pragma mark 调整饱和度
-(void)changeStaturation{
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:1.0] forKey:@"inputSaturation"];//设置滤镜参数
//    [self setImage];
}

#pragma mark 调整亮度
-(void)changeBrightness:(UISlider *)slider{
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputBrightness"];
    [self setImage];
}

#pragma mark 调整对比度
-(void)changeContrast:(UISlider *)slider{
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputContrast"];
    [self setImage];
}

- (void)setImage {
    CIImage *outPutImage = [_colorControlsFilter outputImage];
    CGImageRef temp = [_context createCGImage:outPutImage fromRect:[outPutImage extent]];
    [_MyDelegate changeImage:[UIImage imageWithCGImage:temp]];
    CGImageRelease(temp);//release CGImage
}

@end
