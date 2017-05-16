//
//  PGStepHeadView.h
//  PGStepHeadView
//
//  Created by 张培根 on 2017/5/16.
//
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface PGStepHeadView : UIView


/**
 用标题数组生成控件

 @param titles 字符串数组

 */
-(instancetype)initWithTitles:(NSArray *)titles;

/**
 用步数生成控件

 @param stepCount 需要的步数
 
 */
-(instancetype)initWithStepCount:(int)stepCount;


/**
 设置标题数组
 
 @param titles 字符串数组
 */
-(void)setTitles:(NSArray *)titles;

/**
 设置步数
 
 @param stepCount 需要的步数
 */
-(void)setStepCount:(int)stepCount;


/**
 当前是第几步
 */
-(void)setIndex:(int)index;

/**
 添加到一个xib中的view
 */
-(void)addToView:(UIView *)view;

@end
