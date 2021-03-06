//
//  QMContent.h
//  Q-municate
//
//  Created by Injoit on 1/8/16.
//  Copyright © 2016 QuickBlox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Bolts/Bolts.h>
#import <Quickblox/Quickblox.h>

typedef void(^QMContentProgressBlock)(float progress);

/**
 *  This class provides interface for content files.
 */
@interface QMContent : NSObject

//MARK: - Upload operations

+ (BFTask <QBCBlob *> *)uploadPNGImage:(UIImage *)image
                              progress:(QMContentProgressBlock)progress;

+ (BFTask <QBCBlob *> *)uploadJPEGImage:(UIImage *)image
                               progress:(QMContentProgressBlock)progress;

+ (BFTask <QBCBlob *> *)uploadData:(NSData *)data
                          fileName:(NSString *)fileName
                       contentType:(NSString *)contentType
                          isPublic:(BOOL)isPublic
                          progress:(QMContentProgressBlock)progress;

//MARK: - Download operations

+ (BFTask <NSData *> *)downloadFileWithUrl:(NSURL *)url;

+ (BFTask <UIImage *> *)downloadImageWithUrl:(NSURL *)url;

@end
