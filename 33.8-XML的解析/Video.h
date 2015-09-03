//
//  Video.h
//  33.8-XML的解析
//
//  Created by Mac on 14-10-31.
//  Copyright (c) 2014年 MN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Video.h"

@interface Video : NSObject

@property(nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSNumber *videoId;
@property (nonatomic,strong) NSNumber *length;
@property(nonatomic,copy) NSString *videoURL;
@property(nonatomic,copy) NSString *imageURL;
@property(nonatomic,copy) NSString *desc;
@property(nonatomic,copy) NSString *teacher;

@end
