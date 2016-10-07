//
//  XIU_PickerImageCollectionCell.m
//  XIU_PictureSelector
//
//  Created by XIUDeveloper on 16/9/14.
//  Copyright © 2016年 杨岫峰. All rights reserved.
//

#import "XIU_PickerImageCollectionCell.h"

@implementation XIU_PickerImageCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)addMaskLayer{
    CALayer *lay = [[CALayer alloc] init];
//    lay.backgroundColor = [UIColor colorWithWhite:.5f alpha:.5].CGColor;
    lay.backgroundColor = [UIColor redColor].CGColor;
    lay.frame = self.frame;
    [self.layer addSublayer:lay];
}


- (void)applyData:(ALAsset *)asset {
    self.ImageView.image = [UIImage imageWithCGImage:asset.thumbnail];
}


@end
