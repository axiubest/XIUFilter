//
//  XIU_AssetsLibraryManager.h
//  XIU_PictureSelector
//
//  Created by XIUDeveloper on 16/9/13.
//  Copyright © 2016年 杨岫峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import <UIKit/UIKit.h>

@protocol returnAllImageDelegate <NSObject>

-(void)returnAllThumbnailImageArray:(NSMutableArray *)array;
@end

@interface XIU_AssetsLibraryManager : NSObject

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
/**
 *相册列表数组
 */
@property (nonatomic, strong) NSMutableArray *albumsArray;

/*
 *datasource
 */
@property (nonatomic, strong)NSMutableArray * currentArray;

@property (nonatomic, strong) id<returnAllImageDelegate>XIUDelegate;


+(XIU_AssetsLibraryManager *)shareManager;


- (void)checkOpenJurisdictionMethod;

@end
