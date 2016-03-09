//
//  XsingleRotationRecoginzer.h
//  PictureViewer
//
//  Created by xueyongwei on 16/3/7.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    XSTAGXuanzhuan = 51,
    XSTAGTuodong,
}XSTAG;
@interface XsingleRotationRecoginzer : UIGestureRecognizer
@property (nonatomic,assign)BOOL suofang;
@property (nonatomic,assign)BOOL pan;
@property (nonatomic, assign) CGFloat rotation;
@property (nonatomic, assign) CGFloat scale;
@end
