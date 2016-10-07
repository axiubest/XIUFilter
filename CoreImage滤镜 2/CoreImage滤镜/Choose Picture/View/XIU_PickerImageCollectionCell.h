//
//  XIU_PickerImageCollectionCell.h
//  XIU_PictureSelector
//
//  Created by XIUDeveloper on 16/9/14.
//  Copyright © 2016年 杨岫峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface XIU_PickerImageCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

- (void)addMaskLayer;
- (void)applyData:(ALAsset *)asset;

@end
