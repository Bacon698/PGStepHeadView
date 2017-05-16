//
//  PGStepHeadView.m
//  PGStepHeadView
//
//  Created by 张培根 on 2017/5/16.
//
//

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define _lineHeigh 1
#define _iconTop 20
#define _titleInterval 10
#define _titleFont 15
#define _flankInterval 20 //第一个和最后一个两边的边距

#import "PGStepHeadView.h"


typedef NS_ENUM(NSUInteger, viewType) {
    iconView,
    titleView,
};


@interface PGStepHeadView (){
    NSArray *_iconNameSelectedArray;
    NSArray *_iconNameUnselectedArray;
    NSArray *_titles;
    int _stepCount;
    
    UIColor *_lineColor;
    UIColor *_titleColorSelected;
    UIColor *_titleColorUnselected;
    
    viewType _viewType;
    
    BOOL _equalInterval;
}

@property (strong,nonatomic) NSMutableArray *iconButtonArray;
@property (strong,nonatomic) NSMutableArray *titleButtonArray;
@property (strong,nonatomic) NSMutableArray *lineLabelArray;

@end

@implementation PGStepHeadView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lineColor = [UIColor lightGrayColor];
        _titleColorSelected = [UIColor colorWithRed:111/255.0f green:142/255.0f blue:195/255.0f alpha:1];
        _titleColorUnselected = [UIColor lightGrayColor];
        _iconNameSelectedArray = @[@"process_one_light",@"process_two_light",@"process_three_light",@"process_three_light",@"process_three_light"];
        _iconNameUnselectedArray = @[@"process_one_gray",@"process_two_gray",@"process_three_gray",@"process_three_gray",@"process_three_gray",@"process_three_gray"];
        
    }
    return self;
}

-(instancetype)initWithTitles:(NSArray *)titles equalInterval:(BOOL)equalInterval{

    _equalInterval = equalInterval;
    self = [self initWithTitles:titles];
    return self;
    
}
-(instancetype)initWithTitles:(NSArray *)titles{
    self = [self init];
    [self setTitles:titles];
    return self;
}

-(instancetype)initWithStepCount:(int)stepCount{
    self = [self init];
    [self setStepCount:stepCount];
    return self;
}

-(void)setStepCount:(int)stepCount{
    _viewType = iconView;
    _stepCount =stepCount;
    
    if (_iconNameUnselectedArray.count < stepCount || _iconNameSelectedArray.count < stepCount ) {
        NSLog(@"图片数量不足");
        return;
    }
    for (int i = 0; i < stepCount; i++) {
        [self addIconButtonWithIndex:i];
        [self addLineLabelWithIndex:i];
        if (i == stepCount - 1) {
            [self addLineLabelWithIndex:i+1];
        }
    }
    
    //布局各个控件
    for (int i = 0; i < stepCount; i++) {
        [self layoutIconButtonAndLineWithIndex:i iconCenter:YES];
    }
    
}

-(void)setTitles:(NSArray *)titles{
    _viewType = titleView;
    _titles = titles;
    
    if (_iconNameUnselectedArray.count < titles.count || _iconNameSelectedArray.count < titles.count) {
        NSLog(@"图片数量不足");
        return;
    }
    
    //初始各个控件
    for (int i = 0; i < titles.count; i++) {
        if ([titles[i] isKindOfClass:[NSString class]]) {
            [self addIconButtonWithIndex:i];
            [self addTitleButtonWithIndex:i];
            [self addLineLabelWithIndex:i];
            if (i == titles.count - 1) {
                [self addLineLabelWithIndex:i+1];
            }
        }else{
            NSLog(@"标题名称有误");
        }
    }
    
    //布局各个控件
    for (int i = 0; i < titles.count; i++) {
        [self layoutIconButtonAndLineWithIndex:i iconCenter:NO];
        [self layoutTitleButtonWithIndex:i];
    }
}

-(void)setIndex:(int)index{
    
    NSInteger count = _stepCount?_stepCount:_titles.count;
    if (index > count) {
        return;
    }
    for (int i = 0; i < count; i++) {
        UIButton *iconButton = self.iconButtonArray[i];
        if (i == index - 1) {
            iconButton.selected = YES;
        }else{
            iconButton.selected = NO;
        }
        
        if (_viewType == titleView) {
            UIButton *titleButton = self.titleButtonArray[i];
            if (i == index - 1) {
            titleButton.selected = YES;
            }else{
                titleButton.selected = NO;
            }

        }
    }
}

-(void)addIconButtonWithIndex:(int)i{
    
    UIImage *selectedImage = [UIImage imageNamed:_iconNameSelectedArray[i]];
    UIImage *unselectedImage = [UIImage imageNamed:_iconNameUnselectedArray[i]];
    
    UIButton *iconButton = [UIButton new];
    [iconButton setImage:selectedImage forState:UIControlStateSelected];
    [iconButton setImage:unselectedImage forState:UIControlStateNormal];
    
    [self addSubview:iconButton];
    [self.iconButtonArray addObject:iconButton];
    
}

-(void)addTitleButtonWithIndex:(int)i{
    UIButton *titleButton = [UIButton new];
    [titleButton setTitle:_titles[i] forState:UIControlStateNormal];
    [titleButton setTitle:_titles[i] forState:UIControlStateSelected];
    [titleButton setTitleColor:_titleColorUnselected forState:UIControlStateNormal];
    [titleButton setTitleColor:_titleColorSelected forState:UIControlStateSelected];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:_titleFont];
    
    [self addSubview:titleButton];
    [self.titleButtonArray addObject:titleButton];
}

-(void)addLineLabelWithIndex:(int)i{
    
    UILabel *label = [UILabel new];
    label.backgroundColor = _lineColor;
    
    [self addSubview:label];
    [self.lineLabelArray addObject:label];
    
    if (i == 0 || i == (_stepCount?_stepCount:_titles.count)) {
        label.hidden = YES;
    }
    
}

-(void)layoutTitleButtonWithIndex:(int)i{
    
    UIButton *button = self.iconButtonArray[i];
    UIButton *titleButton = self.titleButtonArray[i];

    [titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(button.mas_bottom).offset(_titleInterval);
        make.centerX.mas_equalTo(button);
    }];
    
}


/**
 
 布局图标和线

 @param iconCenter 图标是否竖向居中显示
 
 */
-(void)layoutIconButtonAndLineWithIndex:(int)i iconCenter:(BOOL)iconCenter{
    
    UILabel *frontLabel = self.lineLabelArray[i];
    UILabel *behindLabel = self.lineLabelArray[i+1];
    UIButton *button = self.iconButtonArray[i];
    UIImage *image = [UIImage imageNamed:_iconNameUnselectedArray[i]];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(image.size.width);
        make.left.mas_equalTo(frontLabel.mas_right);
        make.right.mas_equalTo(behindLabel.mas_left);
    }];
    
    if (iconCenter) {
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
        }];
    }else{
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(_iconTop);
        }];
    }
    
    //每布局一个button，只给它前边的line布局。
    if (i == 0) {
        
        UILabel *firstLabel = self.lineLabelArray[i];//第一个button只负责最前边的Line,最前边的line不同所以单独拿出来
        UILabel *behindLabel = self.lineLabelArray[i+1];
        
        [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.height.mas_equalTo(_lineHeigh);
            make.centerY.mas_equalTo(button);
        }];
        
        if (_equalInterval) {
            [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
               make.width.mas_equalTo(behindLabel);
            }];
        }else{
            [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(_flankInterval);
            }];
        }

    }else if (i == (_stepCount?_stepCount:_titles.count) - 1) {//最后一个button负责两个Line
        
        UILabel *frontLabel = self.lineLabelArray[i];
        UILabel *LastLabel = self.lineLabelArray[i+1];
        
        [frontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(_lineHeigh);
            make.centerY.mas_equalTo(button);
        }];
        
        [LastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(_lineHeigh);
            make.centerY.mas_equalTo(button);
            make.right.mas_equalTo(self);
        }];
        
        if (_equalInterval) {
            [LastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(frontLabel);
            }];
        }else{
            [LastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(_flankInterval);
            }];
        }
        
        
    }else{
        
        UILabel *frontLabel = self.lineLabelArray[i];
        UILabel *behindLabel = self.lineLabelArray[i+1];
        
        [frontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(_lineHeigh);
            make.centerY.mas_equalTo(button);
            make.width.equalTo(behindLabel);//这个比较难理解，line的宽度相等
        }];
        
    }
    
}

-(UILabel *)lineLabelWithIndex:(int)index{
    UILabel *label = [UILabel new];
    return label;
}

-(void)addToView:(UIView *)view{
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view);
    }];
}

-(NSMutableArray *)iconButtonArray{
    if (!_iconButtonArray) {
        _iconButtonArray = [NSMutableArray array];
    }
    return _iconButtonArray;
}

-(NSMutableArray *)titleButtonArray{
    if (!_titleButtonArray) {
        _titleButtonArray = [NSMutableArray array];
    }
    return _titleButtonArray;
}

-(NSMutableArray *)lineLabelArray{
    if (!_lineLabelArray) {
        _lineLabelArray = [NSMutableArray array];
    }
    return _lineLabelArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
