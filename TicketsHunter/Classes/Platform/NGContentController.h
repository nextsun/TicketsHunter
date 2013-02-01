//
//  NGContentController.h
//  TicketsHunter
//
//  Created by Lei Sun on 2/1/13.
//  Copyright (c) 2013 EasyTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMTabView.h"

@interface NGContentController : NSObject<UIScrollViewDelegate>
{
    NSArray *contentList;
    
    UIScrollView *scrollView;
	UIPageControl *pageControl;
    NSMutableArray *viewControllers;
    
    JMTabView *tabView;
    
    // To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
    
    
    UIView* view;
    
}
- (id)initWithFrame:(CGRect)frame;
@property (nonatomic, retain) NSArray *contentList;

- (UIView *)view;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) IBOutlet JMTabView *tabView;
@property (nonatomic, retain) NSMutableArray *viewControllers;
//-(void)autoReSizeScrollContentSize;
//- (void)changePage:(id)sender;
//- (void)loadScrollViewWithPage:(int)page;
@end
