//
//  QMTableViewCell.m
//  Qmunicate
//
//  Created by Andrey Ivanov on 11.07.14.
//  Copyright (c) 2014 Quickblox. All rights reserved.
//

#import "QMTableViewCell.h"
#import "QMImageView.h"

@interface QMTableViewCell()

@end

@implementation QMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.qmImageView.imageViewType = QMImageViewTypeCircle;
}

- (void)setUserImageWithUrl:(NSURL *)userImageUrl {
    
    UIImage *placeHolder = [UIImage imageNamed:@"upic-placeholder"];
    [self.qmImageView sd_setImageWithURL:userImageUrl progress:nil placeholderImage:placeHolder];
}

- (void)setUserImage:(UIImage *)image withKey:(NSString *)key {
    if (!image) {
        image = [UIImage imageNamed:@"upic-placeholder"];
    }
    [self.qmImageView sd_setImage:image withKey:key];
}

@end
