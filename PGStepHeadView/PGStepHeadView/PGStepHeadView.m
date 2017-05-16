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

#import "PGStepHeadView.h"

@interface PGStepHeadView (){
    NSArray *_iconNameSelectedArray;
    NSArray *_iconNameUnselectedArray;
    NSArray *_titles;
    
    UIColor *_lineColor;
    UIColor *_titleColorSelected;
    UIColor *_titleColorUnselected;
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
        _titleColorSelected = [UIColor orangeColor];
        _titleColorUnselected = [UIColor lightGrayColor];
        _iconNameSelectedArray = @[@"process_one_light",@"process_two_light",@"process_three_light",@"process_three_light"];
        _iconNameUnselectedArray = @[@"process_one_gray",@"process_two_gray",@"process_three_gray",@"process_three_gray"];
        
    }
    return self;
}

-(instancetype)initWithTitles:(NSArray *)titles{
    self = [self init];
    _titles = titles;
    [self setUpViewWithTitles:titles];
    return self;
}

-(void)setUpViewWithTitles:(NSArray *)titles{
    
    if (_iconNameUnselectedArray.count < titles.count || _iconNameSelectedArray.count < titles.count) {
        NSLog(@"图片数量不足");
        return;
    }
    
    //初始各个控件
    for (int i = 0; i < titles.count; i++) {
        if ([titles[i] isKindOfClass:[NSString class]]) {
            [self addButtonWithIndex:i];
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
        [self layoutSubviewsWithIndex:i];
    }
}

-(void)addButtonWithIndex:(int)i{
    
    UIImage *selectedImage = [UIImage imageNamed:_iconNameUnselectedArray[i]];
    UIImage *unselectedImage = [UIImage imageNamed:_iconNameUnselectedArray[i]];
    
    UIButton *iconButton = [UIButton new];
    [iconButton setImage:selectedImage forState:UIControlStateNormal];
    [iconButton setImage:unselectedImage forState:UIControlStateSelected];
    
    [self addSubview:iconButton];
    [self.iconButtonArray addObject:iconButton];
    
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
    
    if (i == 0 || i == _titles.count) {
        label.hidden = YES;
    }
}


-(void)layoutSubviewsWithIndex:(int)i{
    
    UILabel *frontLabel = self.lineLabelArray[i];
    UILabel *behindLabel = self.lineLabelArray[i+1];
    UIButton *button = self.iconButtonArray[i];
    UIImage *image = [UIImage imageNamed:_iconNameUnselectedArray[i]];
    UIButton *titleButton = self.titleButtonArray[i];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(image.size.width);
        make.top.mas_equalTo(self).offset(_iconTop);
        make.left.mas_equalTo(frontLabel.mas_right);
        make.right.mas_equalTo(behindLabel.mas_left);
    }];
    
    [titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(button.mas_bottom).offset(_titleInterval);
        make.centerX.mas_equalTo(button);
    }];
    
    //每布局一个button，只给它前边的line布局。
    if (i == 0) {
        
        UILabel *firstLabel = self.lineLabelArray[i];//第一个button只负责最前边的Line,最前边的line不同所以单独拿出来
        
        [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.height.mas_equalTo(_lineHeigh);
            make.centerY.mas_equalTo(button);
            make.width.mas_equalTo(20);
        }];

    }else if (i == _titles.count - 1) {//最后一个button负责两个Line
        
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
            make.width.mas_equalTo(20);
        }];
        
        
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

-(UIButton *)iconButtonWithIndex:(int)i{
    
    UIImage *selectedImage = [UIImage imageNamed:_iconNameUnselectedArray[i]];
    UIImage *unselectedImage = [UIImage imageNamed:_iconNameUnselectedArray[i]];
    
    UIButton *button = [UIButton new];
    [button setImage:selectedImage forState:UIControlStateNormal];
    [button setImage:unselectedImage forState:UIControlStateSelected];
    
    [self getCenterX:i];
    
    [self addSubview:button];
    [self.iconButtonArray addObject:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(unselectedImage.size.width);
        make.centerX.mas_equalTo(self.mas_left).offset([self getCenterX:i]);
        make.top.mas_equalTo(self).offset(20);
    }];
    
    return button;
}

-(CGFloat)getCenterX:(int)i{
    return SCREEN_WIDTH / (_titles.count + 1) * (i + 1);
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
