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

-(instancetype)initWithTitles:(NSArray *)titles;

-(void)addToView:(UIView *)view;

@end
