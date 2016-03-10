//
//  XsingleRotationRecoginzer.h
//  PictureViewer
//
//  Created by xueyongwei on 16/3/7.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
//设置目标视图的tag即可改变拖动还是旋转的状态
typedef enum {
    XSTAGTuodong,
    XSTAGXuanzhuan,
}XSTAG;
@interface XsingleRotationRecoginzer : UIGestureRecognizer
@property (nonatomic,assign)BOOL suofang;
@property (nonatomic,assign)BOOL pan;
@property (nonatomic, assign) CGFloat rotation;
@property (nonatomic, assign) CGFloat scale;
@end
