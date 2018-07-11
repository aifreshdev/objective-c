//
//  UIScrollView+InfiniteScrollView.m
//  InfiniteScrollViewDemo
//
//  Created by Vincent li on 3/7/2018.
//  Copyright © 2018 Vincent li. All rights reserved.
//

#import "InfiniteScrollView.h"

@interface InfiniteScrollView()

@property (nonatomic, assign) CGRect screenRect;
@property (nonatomic, strong) NSMutableArray *visibleLabels;
@property (nonatomic, strong) UIView *labelContainerView;

@property (nonatomic, assign) UIPageControl *pageControl;
@property (nonatomic,  assign) BOOL isScrolling;

@end

@implementation InfiniteScrollView

- (id) initWithCoder:(NSCoder *)aDecoder {
    if((self = [super initWithCoder:aDecoder])){
         // set a default width size
        self.contentSize = CGSizeMake(5000, self.frame.size.height);
        
        self.pagingEnabled = YES;
        self.screenRect = [[UIScreen mainScreen] bounds];
        
        _labelContainerView = [[UIView alloc] init];
        _labelContainerView.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height/2);
        [self addSubview: _labelContainerView];
        
        // disable touch event.
        [self.labelContainerView setUserInteractionEnabled:NO];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect visibleBounds = [self convertRect:[self bounds] toView:self.labelContainerView];
    CGFloat minimumVisibleX = CGRectGetMinX(visibleBounds);
    CGFloat maximumVisibleX = CGRectGetMaxX(visibleBounds);
    
    NSLog(@"%f, %f", minimumVisibleX, maximumVisibleX);
}

- (UILabel *)createNewLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,  self.screenRect.size.width, 80)];
    [label setBackgroundColor:UIColor.blueColor];
    [label setNumberOfLines:10];
    [label setText:@"//////////Page//////////"];
    [self.labelContainerView addSubview:label];
    
    return label;
}

- (CGFloat) addViewOfRight : (CGFloat) rightEdge {
    
    UILabel *label = [self createNewLabel];
    CGRect frame = [label frame];
    frame.origin.x = rightEdge;
    frame.origin.y = [self.labelContainerView bounds].size.height - frame.size.height;
    [label setFrame:frame];
    
    return CGRectGetMaxX(frame);
}

- (void) initData{
    CGFloat rightEdge = 0.0f;
    for(int i=0;i<10;i++){
        [self createNewLabel];
        
        UILabel *lastLabel = [self.visibleLabels lastObject];
        rightEdge = [self addViewOfRight: rightEdge];
    }
    
    [self setContentOffset:CGPointMake(0, 0) animated:YES];
}


@end
