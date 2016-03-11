//
//  Line.h
//  PictureViewer
//
//  Created by xueyongwei on 16/3/8.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Line : NSObject
@property (nonatomic,assign)CGPoint begin;
@property (nonatomic,assign)CGPoint end;
@property (nonatomic,retain)UIColor* drawColor;

@end
