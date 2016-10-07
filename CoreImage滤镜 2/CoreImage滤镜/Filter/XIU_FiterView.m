//
//  XIU_FiterView.m
//  CoreImage滤镜
//
//  Created by A-XIU on 16/9/8.
//  Copyright © 2016年 XIU. All rights reserved.


#import "XIU_FiterView.h"
#import "XIUImageMainButton.h"

#import "ImageUtil.h"




//LOMO
const float colormatrix_lomo[] = {
    1.7f,  0.1f, 0.1f, 0, -73.1f,
    0,  1.7f, 0.1f, 0, -73.1f,
    0,  0.1f, 1.6f, 0, -73.1f,
    0,  0, 0, 1.0f, 0 };

//黑白
const float colormatrix_heibai[] = {
    0.8f,  1.6f, 0.2f, 0, -163.9f,
    0.8f,  1.6f, 0.2f, 0, -163.9f,
    0.8f,  1.6f, 0.2f, 0, -163.9f,
    0,  0, 0, 1.0f, 0 };
//复古
const float colormatrix_huajiu[] = {
    0.2f,0.5f, 0.1f, 0, 40.8f,
    0.2f, 0.5f, 0.1f, 0, 40.8f,
    0.2f,0.5f, 0.1f, 0, 40.8f,
    0, 0, 0, 1, 0 };

//哥特
const float colormatrix_gete[] = {
    1.9f,-0.3f, -0.2f, 0,-87.0f,
    -0.2f, 1.7f, -0.1f, 0, -87.0f,
    -0.1f,-0.6f, 2.0f, 0, -87.0f,
    0, 0, 0, 1.0f, 0 };

//锐化
const float colormatrix_ruise[] = {
    4.8f,-1.0f, -0.1f, 0,-388.4f,
    -0.5f,4.4f, -0.1f, 0,-388.4f,
    -0.5f,-1.0f, 5.2f, 0,-388.4f,
    0, 0, 0, 1.0f, 0 };


//淡雅
const float colormatrix_danya[] = {
    0.6f,0.3f, 0.1f, 0,73.3f,
    0.2f,0.7f, 0.1f, 0,73.3f,
    0.2f,0.3f, 0.4f, 0,73.3f,
    0, 0, 0, 1.0f, 0 };

//酒红
const float colormatrix_jiuhong[] = {
    1.2f,0.0f, 0.0f, 0.0f,0.0f,
    0.0f,0.9f, 0.0f, 0.0f,0.0f,
    0.0f,0.0f, 0.8f, 0.0f,0.0f,
    0, 0, 0, 1.0f, 0 };

//清宁
const float colormatrix_qingning[] = {
    0.9f, 0, 0, 0, 0,
    0, 1.1f,0, 0, 0,
    0, 0, 0.9f, 0, 0,
    0, 0, 0, 1.0f, 0 };

//浪漫
const float colormatrix_langman[] = {
    0.9f, 0, 0, 0, 63.0f,
    0, 0.9f,0, 0, 63.0f,
    0, 0, 0.9f, 0, 63.0f,
    0, 0, 0, 1.0f, 0 };

//光晕
const float colormatrix_guangyun[] = {
    0.9f, 0, 0,  0, 64.9f,
    0, 0.9f,0,  0, 64.9f,
    0, 0, 0.9f,  0, 64.9f,
    0, 0, 0, 1.0f, 0 };

//蓝调
const float colormatrix_landiao[] = {
    2.1f, -1.4f, 0.6f, 0.0f, -31.0f,
    -0.3f, 2.0f, -0.3f, 0.0f, -31.0f,
    -1.1f, -0.2f, 2.6f, 0.0f, -31.0f,
    0.0f, 0.0f, 0.0f, 1.0f, 0.0f
};

//梦幻
const float colormatrix_menghuan[] = {
    0.8f, 0.3f, 0.1f, 0.0f, 46.5f,
    0.1f, 0.9f, 0.0f, 0.0f, 46.5f,
    0.1f, 0.3f, 0.7f, 0.0f, 46.5f,
    0.0f, 0.0f, 0.0f, 1.0f, 0.0f
};

//夜色
const float colormatrix_yese[] = {
    1.0f, 0.0f, 0.0f, 0.0f, -66.6f,
    0.0f, 1.1f, 0.0f, 0.0f, -66.6f,
    0.0f, 0.0f, 1.0f, 0.0f, -66.6f,
    0.0f, 0.0f, 0.0f, 1.0f, 0.0f
};

@interface XIU_FiterView ()<UIScrollViewDelegate>
@property (strong, nonatomic)  UIScrollView *XIUScrollView;
@property (nonatomic, weak)UIImage *ChangeImg;
@property (nonatomic, strong)NSMutableArray *pickerData;

@end

@implementation XIU_FiterView
-(void)awakeFromNib{
    [super awakeFromNib];
    [self XIUScrollView];
}
-(NSMutableArray *)pickerData {
    if (!_pickerData) {
        _pickerData = [[NSMutableArray alloc] initWithObjects:
                       @"OriginImage",
                       @"CIPhotoEffectMono",
                       @"CIPhotoEffectChrome",
                       @"CIPhotoEffectFade",
                       @"CIPhotoEffectInstant",
                       @"CIPhotoEffectNoir",
                       @"CIPhotoEffectProcess",
                       @"CIPhotoEffectTonal",
                       @"CIPhotoEffectTransfer",
                       @"CISRGBToneCurveToLinear",
                       @"CIVignetteEffect",
                       nil];
        
    }
    return _pickerData;
}

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
    _ChangeImg = img;
    NSData *imgData = UIImageJPEGRepresentation(img, 0.1);
    UIImage *compressImg = [UIImage imageWithData:imgData];
    CGFloat BUTTON_SIZE = self.XIUScrollView.frame.size.height * 0.8;
    CGFloat BUTTON_X = self.XIUScrollView.frame.size.height * 0.05;
    for (int i = 0; i < 11; i++) {
    XIUImageMainButton *btn = [[XIUImageMainButton alloc] initWithFrame:CGRectMake(10 + i * BUTTON_SIZE * 0.6, BUTTON_X, BUTTON_SIZE, BUTTON_SIZE)];
        [btn addTarget:self action:@selector(chickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.XIUScrollView addSubview:btn];
        btn.tag = i + 100;
//        [self addBtnType:btn img:compressImg];
        [self addBtnType:btn img:[self scaleToSize:compressImg size:CGSizeMake(btn.frame.size.width, btn.frame.size.height)]];


        }
        _XIUScrollView.contentSize = CGSizeMake(BUTTON_SIZE * 11  + BUTTON_SIZE * 0.6 * 11, 100);
}


//对图片进行压缩
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (void)addBtnType:(XIUImageMainButton *)button img:(UIImage *)img {
    switch (button.tag) {
    case 100:
        button.lab.text = @"原图";
        button.img.image = img;
        break;
    case 101:
        button.lab.text = @"CIPhotoEffectMono";
        button.img.image = [ImageUtil imageWithImage:img filterName:@"CIPhotoEffectMono"];
        break;
    case 102:
        button.lab.text = @"CIPhotoEffectChrome";
        button.img.image = [ImageUtil imageWithImage:img filterName:@"CIPhotoEffectChrome"];
        break;
    case 103:
        button.lab.text = @"CIPhotoEffectFade";
        button.img.image = [ImageUtil imageWithImage:img filterName:@"CIPhotoEffectFade"];
        break;
    case 104:
        button.lab.text = @"CIPhotoEffectInstant";
        button.img.image = [ImageUtil imageWithImage:img filterName:@"CIPhotoEffectInstant"];
        break;
    case 105:
        button.lab.text = @"CIPhotoEffectNoir";
        button.img.image = [ImageUtil imageWithImage:img filterName:@"CIPhotoEffectNoir"];
        break;
    case 106:
        button.lab.text = @"CIPhotoEffectProcess";
        button.img.image = [ImageUtil imageWithImage:img filterName:@"CIPhotoEffectProcess"];
        break;
    case 107:
        button.lab.text = @"CIPhotoEffectTonal";
        button.img.image = [ImageUtil imageWithImage:img filterName:@"CIPhotoEffectTonal"];
        break;
    case 108:
        button.lab.text = @"CIPhotoEffectTransfer";
        button.img.image = [ImageUtil imageWithImage:img filterName:@"CIPhotoEffectTransfer"];
        break;
    case 109:
        button.lab.text = @"CISRGBToneCurveToLinear";
        button.img.image = [ImageUtil imageWithImage:img filterName:@"CISRGBToneCurveToLinear"];
        break;
    case 110:
        button.lab.text = @"CIVignetteEffect";
        button.img.image = [ImageUtil imageWithImage:img filterName:@"CIVignetteEffect"];
        break;

    }
}

//- (void)addBtnType:(XIUImageMainButton *)button img:(UIImage *)img {
//    switch (button.tag) {
//        case 100:
//            button.lab.text = @"原图";
//            button.img.image = img;
//            break;
//        case 101:
//            button.lab.text = @"LOMO";
//            button.img.image = [ImageUtil imageWithImage:img withColorMatrix:colormatrix_lomo];
//            break;
//        case 102:
//            button.lab.text = @"黑白";
//            button.img.image = [ImageUtil imageWithImage:img withColorMatrix:colormatrix_heibai];
//            break;
//        case 103:
//            button.lab.text = @"复古";
//            button.img.image = [ImageUtil imageWithImage:img withColorMatrix:colormatrix_huajiu];
//            break;
//        case 104:
//            button.lab.text = @"哥特";
//            button.img.image = [ImageUtil imageWithImage:img withColorMatrix:colormatrix_gete];
//            break;
//        case 105:
//            button.lab.text = @"锐化";
//            button.img.image = [ImageUtil imageWithImage:img withColorMatrix:colormatrix_ruise];
//            break;
//        case 106:
//            button.lab.text = @"淡雅";
//            button.img.image = [ImageUtil imageWithImage:img withColorMatrix:colormatrix_danya];
//            break;
//        case 107:
//            button.lab.text = @"酒红";
//            button.img.image = [ImageUtil imageWithImage:img withColorMatrix:colormatrix_jiuhong];
//            break;
//        case 108:
//            button.lab.text = @"清宁";
//            button.img.image = [ImageUtil imageWithImage:img withColorMatrix:colormatrix_qingning];
//            break;
//        case 109:
//            button.lab.text = @"浪漫";
//            button.img.image = [ImageUtil imageWithImage:img withColorMatrix:colormatrix_langman];
//            break;
//        case 110:
//            button.lab.text = @"光晕";
//            button.img.image = [ImageUtil imageWithImage:img withColorMatrix:colormatrix_guangyun];
//            break;
//        case 111:
//            button.lab.text = @"蓝调";
//            button.img.image = [ImageUtil imageWithImage:img withColorMatrix:colormatrix_landiao];
//            break;
//        case 112:
//            button.lab.text = @"梦幻";
//            button.img.image = [ImageUtil imageWithImage:img withColorMatrix:colormatrix_menghuan];
//            break;
//        case 113:
//            button.lab.text = @"夜色";
//            button.img.image = [ImageUtil imageWithImage:img withColorMatrix:colormatrix_yese];
//            break;
//            
//        default:
//            break;
//    }
//    
//}

/*
 @"OriginImage",
 @"CIPhotoEffectMono",
 @"CIPhotoEffectChrome",
 @"CIPhotoEffectFade",
 @"CIPhotoEffectInstant",
 @"CIPhotoEffectNoir",
 @"CIPhotoEffectProcess",
 @"CIPhotoEffectTonal",
 @"CIPhotoEffectTransfer",
 @"CISRGBToneCurveToLinear",
 @"CIVignetteEffect",
 
 *
 */

- (void)chickedButton:(XIUImageMainButton *)sender {
    switch (sender.tag) {
        case 100:
            
            [_MyDelegate ChangeImage:_ChangeImg];
            break;
        case 101:
           
//            [_MyDelegate ChangeImage: [ImageUtil imageWithImage:_ChangeImg withColorMatrix:colormatrix_lomo]];
            [_MyDelegate ChangeImage:[ImageUtil imageWithImage:_ChangeImg filterName:@"CIPhotoEffectMono"]];
            break;
        case 102:
            
//            [_MyDelegate ChangeImage:[ImageUtil imageWithImage:_ChangeImg withColorMatrix:colormatrix_heibai]];
                        [_MyDelegate ChangeImage:[ImageUtil imageWithImage:_ChangeImg filterName:@"CIPhotoEffectChrome"]];
            break;
        case 103:

//           [_MyDelegate ChangeImage: [ImageUtil imageWithImage:_ChangeImg withColorMatrix:colormatrix_huajiu]];
                        [_MyDelegate ChangeImage:[ImageUtil imageWithImage:_ChangeImg filterName:@"CIPhotoEffectInstant"]];
            break;
        case 104:

//             [_MyDelegate ChangeImage: [ImageUtil imageWithImage:_ChangeImg withColorMatrix:colormatrix_gete]];
                        [_MyDelegate ChangeImage:[ImageUtil imageWithImage:_ChangeImg filterName:@"CIPhotoEffectNoir"]];
            break;
        case 105:
            
//             [_MyDelegate ChangeImage:[ImageUtil imageWithImage:_ChangeImg withColorMatrix:colormatrix_ruise]];
                        [_MyDelegate ChangeImage:[ImageUtil imageWithImage:_ChangeImg filterName:@"CIPhotoEffectProcess"]];
            break;
        case 106:

//           [_MyDelegate ChangeImage: [ImageUtil imageWithImage:_ChangeImg withColorMatrix:colormatrix_danya]];
                        [_MyDelegate ChangeImage:[ImageUtil imageWithImage:_ChangeImg filterName:@"CIPhotoEffectTonal"]];
            break;
        case 107:
//             [_MyDelegate ChangeImage: [ImageUtil imageWithImage:_ChangeImg withColorMatrix:colormatrix_jiuhong]];
                        [_MyDelegate ChangeImage:[ImageUtil imageWithImage:_ChangeImg filterName:@"CIPhotoEffectTransfer"]];
            break;
        case 108:
//           [_MyDelegate ChangeImage:[ImageUtil imageWithImage:_ChangeImg withColorMatrix:colormatrix_qingning]];
                        [_MyDelegate ChangeImage:[ImageUtil imageWithImage:_ChangeImg filterName:@"CISRGBToneCurveToLinear"]];
            break;
        case 109:
           
//            [_MyDelegate ChangeImage: [ImageUtil imageWithImage:_ChangeImg withColorMatrix:colormatrix_langman]];
                        [_MyDelegate ChangeImage:[ImageUtil imageWithImage:_ChangeImg filterName:@"CIVignetteEffect"]];
            break;
        case 110:
//            [_MyDelegate ChangeImage: [ImageUtil imageWithImage:_ChangeImg withColorMatrix:colormatrix_guangyun]];
                        [_MyDelegate ChangeImage:[ImageUtil imageWithImage:_ChangeImg filterName:@"CIPhotoEffectFade"]];
            break;
        case 111:

            [_MyDelegate ChangeImage:  [ImageUtil imageWithImage:_ChangeImg withColorMatrix:colormatrix_landiao]];
            break;
        case 112:
           [_MyDelegate ChangeImage: [ImageUtil imageWithImage:_ChangeImg withColorMatrix:colormatrix_menghuan]];
            break;
        case 113:
          
            [_MyDelegate ChangeImage: [ImageUtil imageWithImage:_ChangeImg withColorMatrix:colormatrix_yese]];
            break;
            
        default:
            break;
    }
}
@end

