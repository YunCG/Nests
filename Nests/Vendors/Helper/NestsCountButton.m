//
//  CountdownButton.m
//  CountdownButton
//
//  Created by Wayn on 13-7-6.
//  Copyright (c) 2013年 Wayn. All rights reserved.
//

#import "NestsCountButton.h"

@interface NestsCountButton ()

@property (nonatomic, assign) BOOL inCountDown;
@property (nonatomic, assign) int countSeconds;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, strong) NSString *normalTitle;
@property (nonatomic, strong) NSString *highlightedTitle;
@property (nonatomic, strong) NSString *disabledTitle;
@property (nonatomic, strong) NSString *selectedTitle;



@end

@implementation NestsCountButton

@synthesize useAnimation;
@synthesize seconds;
@synthesize offset;
@synthesize inCountDown;
@synthesize countSeconds;
@synthesize timer = _timer;
@synthesize timerLabel = _timerLabel;

#pragma mark - Default Values

#define DEFAULT_USE_ANIMATION	YES
#define DEFAULT_AUTO_START      YES
#define DEFAULT_SECONDS			10
#define DEFAULT_OFFSET          CGPointMake(5, 0)

#pragma mark - Init Methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        useAnimation = DEFAULT_USE_ANIMATION;
        seconds = DEFAULT_SECONDS;
        offset = DEFAULT_OFFSET;
        
        self.titleLabel.numberOfLines = 0;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        useAnimation = DEFAULT_USE_ANIMATION;
        seconds = DEFAULT_SECONDS;
        offset = DEFAULT_OFFSET;
        
        self.titleLabel.numberOfLines = 0;
    }
    return self;
}

#pragma mark - Actions

- (void)startCountDown
{
    self.enabled = NO;
      self.normalTitle         =[self  titleForState:UIControlStateNormal];
     self.highlightedTitle   =[self  titleForState:UIControlStateHighlighted];
     self.disabledTitle      =[self  titleForState:UIControlStateDisabled];
     self.selectedTitle      =[self  titleForState:UIControlStateSelected];
    
    [self setTitle:@"" forState:UIControlStateNormal];
    [self setTitle:@"" forState:UIControlStateHighlighted];
    [self setTitle:@"" forState:UIControlStateDisabled];
    [self setTitle:@"" forState:UIControlStateSelected];
  
    
    countSeconds = seconds;
    CGFloat timerWidth = [[NSString stringWithFormat:@"%ds", seconds] sizeWithFont:self.titleLabel.font].width;
    
    if (_timerLabel == nil)
        _timerLabel = [[UILabel alloc] init];
    
    CGRect frame = CGRectOffset(self.titleLabel.frame, 5, 0);
    
//    frame.size.width = timerWidth;
    _timerLabel.frame = frame;
      _timerLabel.text = [NSString stringWithFormat:@"%ds", countSeconds];
    _timerLabel.backgroundColor = [UIColor clearColor];
    _timerLabel.font = self.titleLabel.font;
    _timerLabel.textColor = self.titleLabel.textColor;
    
    self.translatesAutoresizingMaskIntoConstraints = YES;
    
    [self addSubview:_timerLabel];
    
    if (useAnimation) {
        
        [UIView animateWithDuration:.3f
                         animations:^{
                             CGRect frame = self.frame;
//                             frame.size.width = frame.size.width + offset.x + timerWidth;
                             frame.size.height = frame.size.height + offset.y;
                             
                             self.frame = frame;
                         }];
        self.titleEdgeInsets = UIEdgeInsetsMake(0, (-offset.x - timerWidth)/2, 0, 0);
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
}

#pragma mark - Functions

- (void)countDownStoped
{
    self.enabled = YES;
    
    self.titleEdgeInsets = UIEdgeInsetsZero;
    
    if (_timerLabel.superview) {
        [_timerLabel removeFromSuperview];
    }
    if (useAnimation) {
        
        [UIView animateWithDuration:.3f
                         animations:^{
                             CGRect frame = self.frame;
//                             frame.size.width = frame.size.width - offset.x - _timerLabel.frame.size.width;
                             frame.size.height = frame.size.height - offset.y;
                             
                             self.frame = frame;
                         }
         ];
    }
}

- (void)timerRun
{
    countSeconds = countSeconds - 1;
    
  
    _timerLabel.text = [NSString stringWithFormat:@"%ds", countSeconds];
    
    if (countSeconds <= 0) {
        [self countDownStoped];
        [_timer invalidate];
        _timer = nil;
        
        
        countSeconds = seconds;
        
        [self setTitle:self.normalTitle forState:UIControlStateNormal];
         [self setTitle:self.highlightedTitle forState:UIControlStateHighlighted];
         [self setTitle:self.disabledTitle forState:UIControlStateDisabled];
         [self setTitle:self.selectedTitle forState:UIControlStateSelected];
        
       
    }
}

@end
