//
//  XIU_EditView.m
//  CoreImage滤镜
//
//  Created by XIUDeveloper on 16/9/8.
//  Copyright © 2016年 XIU. All rights reserved.
//

#import "XIU_EditView.h"
#import "XIUImageMainButton.h"
#import "XIU_EditImageManager.h"
@interface XIU_EditView ()<UIScrollViewDelegate>
{
    CIFilter *_colorControlsFilter;//色彩滤镜
    CIContext *_context;//Core Image上下文
    CIImage *_image;//我们要编辑的图像
    CIImage *_outputImage;//处理后的图像

}

@property (strong, nonatomic)  UIScrollView *XIUScrollView;

@end

@implementation XIU_EditView
-(void)awakeFromNib{
    [super awakeFromNib];
    [self XIUScrollView];
//    [self initcolorControlsFilter];
}

- (void)initcolorControlsFilter {
    _context = [CIContext contextWithOptions:nil];    _colorControlsFilter=[CIFilter filterWithName:@"CIColorControls"];
    

}

#pragma mark Lazy Method

-(UIScrollView *)XIUScrollView {
    if (!_XIUScrollView) {
        _XIUScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _XIUScrollView.contentSize = CGSizeMake(self.bounds.size.width *10, 100);
        _XIUScrollView.delegate = self;
        [self addSubview:_XIUScrollView];
    }
    return _XIUScrollView;
}

- (void)baseInit:(UIImage *)img {
    CGFloat BUTTON_SIZE = self.XIUScrollView.frame.size.height * 0.8;
    CGFloat BUTTON_X = self.XIUScrollView.frame.size.height * 0.05;
    for (int i = 0; i < 10; i++) {
        XIUImageMainButton *btn = [[XIUImageMainButton alloc] initWithFrame:CGRectMake(10 + i * BUTTON_SIZE * 0.6, BUTTON_X, BUTTON_SIZE, BUTTON_SIZE)];
        btn.tag= i;
        [btn addTarget:self action:@selector(chickedBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.XIUScrollView addSubview:btn];
    }
    _XIUScrollView.contentSize = CGSizeMake(BUTTON_SIZE * 10  + BUTTON_SIZE * 0.6 * 10, 100);
    
}

#pragma  mark chicked button method
- (void)chickedBtn:(UIButton *)sender {
    [_MyDelegate showSlider];
    XIU_EditImageManager *mgr = [XIU_EditImageManager shareManager];
    switch (sender.tag) {
        case 0: {//饱和度
            [mgr changeStaturation];
        }
            break;
            
        default:
            break;
    }
}


//- (void)setImage {
//    CIImage *outPutImage = [_colorControlsFilter outputImage];
//    CGImageRef temp = [_context createCGImage:outPutImage fromRect:[outPutImage extent]];
//    _imageView.image = [UIImage imageWithCGImage:temp];
//    CGImageRelease(temp);//release CGImage
//}
@end
