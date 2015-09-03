//
//  Video.m
//  33.8-XML的解析
//
//  Created by Mac on 14-10-31.
//  Copyright (c) 2014年 MN. All rights reserved.
//

#import "Video.h"

@implementation Video


-(NSString*)description{
  return   [NSString stringWithFormat: @"<%@: %p>  {name: %@ ,videoId: %@, length: %@, videoURL: %@, imageURL: %@, desc: %@, teacher: %@ }",[self class],self,self.name,self.videoId,self.length,self.videoId,self.imageURL,self.desc,self.teacher];
 
}
@end
