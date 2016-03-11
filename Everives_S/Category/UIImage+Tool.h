//
//  UIImage+Tool.h
//  ToolsKit
//
//  Created by 李大鹏 on 14-11-24.
//  Copyright (c) 2014年 lidapeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tool)

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)convertViewToImage;
+ (UIImage *)generatePhotoThumbnail:(UIImage *)image;
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;
+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;

@end

@interface UIImage (animatedGIF)

+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)theData;

+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)theURL;

@end

@interface UIImage (Compress)
- (UIImage *)compressedImage;
@end