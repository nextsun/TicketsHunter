//
//  NGContentController.m
//  TicketsHunter
//
//  Created by Lei Sun on 2/1/13.
//  Copyright (c) 2013 EasyTeam. All rights reserved.
//

#import "NGContentController.h"

#import "CustomTabItem.h"
#import "CustomSelectionView.h"
#import "CustomBackgroundLayer.h"

#import "NGQueryViewController.h"
#import "NGMoreViewController.h"


static NSUInteger kNumberOfPages = 4;

static NSString *NameKey = @"nameKey";
static NSString *ImageKey = @"imageKey";




@implementation NGContentController

@synthesize scrollView, pageControl, viewControllers;
@synthesize tabView;
@synthesize contentList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        
        
        view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        
        NSMutableArray *controllers = [[NSMutableArray alloc] init];
        for (unsigned i = 0; i < kNumberOfPages; i++)
        {
            [controllers addObject:[NSNull null]];
        }
        self.viewControllers = controllers;
        [controllers release];
        
        
        pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        
        // a page is the width of the scroll view
        scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width , frame.size.height-60+8)];
        scrollView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        scrollView.backgroundColor=[UIColor yellowColor];
        
        scrollView.pagingEnabled = YES;
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
        //scrollView.contentMode=UIViewContentModeScaleToFill;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        
        
        [view addSubview:scrollView];
        
        
        pageControl.numberOfPages = kNumberOfPages;
        pageControl.currentPage = 0;
        
        
        
        [self addCustomTabView];
        
        // pages are created on demand
        // load the visible page
        // load the page on either side to avoid flashes when the user starts scrolling
        //
        [self loadScrollViewWithPage:0];
        [self loadScrollViewWithPage:1];
        [self loadScrollViewWithPage:2];
        [self loadScrollViewWithPage:3];
        
    }
    return self;
}
- (UIView *)view
{
    return view;
}

-(void)addCustomTabView;
{
    tabView = [[[JMTabView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 60., self.view.bounds.size.width, 60.)] autorelease];
    tabView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    
    [tabView setDelegate:(id<JMTabViewDelegate>)self];
    
    //    UIImage * standardIcon = [UIImage imageNamed:@"icon3.png"];
    //    UIImage * highlightedIcon = [UIImage imageNamed:@"icon2.png"];
    //
    CustomTabItem * tabItem1 = [CustomTabItem tabItemWithTitle:@"我要购票" icon:[UIImage imageNamed:@"blueArrow"] alternateIcon:[UIImage imageNamed:@"blueArrow"]];
    //tabItem1.badgeNumber=10;
    CustomTabItem * tabItem2 = [CustomTabItem tabItemWithTitle:@"我的订单" icon:[UIImage imageNamed:@"blueArrow"] alternateIcon:[UIImage imageNamed:@"blueArrow"]];
    CustomTabItem * tabItem3 = [CustomTabItem tabItemWithTitle:@"乘客信息" icon:[UIImage imageNamed:@"blueArrow"] alternateIcon:[UIImage imageNamed:@"blueArrow"]];
    CustomTabItem * tabItem4 = [CustomTabItem tabItemWithTitle:@"更    多" icon:[UIImage imageNamed:@"blueArrow"] alternateIcon:[UIImage imageNamed:@"blueArrow"]];
    //    CustomTabItem * tabItem5 = [CustomTabItem tabItemWithTitle:@"Five" icon:standardIcon alternateIcon:highlightedIcon];
    
    [tabView addTabItem:tabItem1];
    [tabView addTabItem:tabItem2];
    [tabView addTabItem:tabItem3];
    [tabView addTabItem:tabItem4];
    //[tabView addTabItem:tabItem5];
    
    [tabView setSelectionView:[CustomSelectionView createSelectionView]];
    [tabView setItemSpacing:1.];
    [tabView setBackgroundLayer:[[[CustomBackgroundLayer alloc] init] autorelease]];
    
    [tabView setSelectedIndex:0];
    //[tabView setMomentary:YES];
    
    [view addSubview:tabView];
}


- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= kNumberOfPages)
        return;
    
    // replace the placeholder if necessary
    UIViewController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [self factoryGetViewController:page];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
        [controller release];
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
        
        //  NSDictionary *numberItem = [self.contentList objectAtIndex:page];
        //        controller.numberImage.image = [UIImage imageNamed:[numberItem valueForKey:ImageKey]];
        //        controller.numberTitle.text = [numberItem valueForKey:NameKey];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    if (tabView) {
        if(page<kNumberOfPages&&page>=0)
        {
            [tabView setSelectedIndex:page];
        }
        //[tabView didSelectItemAtIndex:page];
    }
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender
{
    int page = pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    //[self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    //[self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}
-(UIViewController*)factoryGetViewController:(int)index
{
    switch (index) {
        case 0:
        {
            
            UINavigationController* nav=[[UINavigationController alloc] initWithRootViewController:[[[NGQueryViewController alloc] init]autorelease]];
            [nav.navigationBar setTintColor:[UIColor colorWithRed:0 green:0.5 blue:0.8 alpha:1]];
            return nav;
            break;
        }
        case 1:
        {
            UIViewController* controller= [[UIViewController alloc] init];
            UINavigationController* nav=[[UINavigationController alloc] initWithRootViewController:controller];
            [nav.navigationBar setTintColor:[UIColor colorWithRed:0 green:0.5 blue:0.8 alpha:1]];
            [controller release];
            
            return nav;
            
            
            break;
        }
        case 2:
        {
            UIViewController* controller= [[UIViewController alloc] init];
            UINavigationController* nav=[[UINavigationController alloc] initWithRootViewController:controller];
            [nav.navigationBar setTintColor:[UIColor colorWithRed:0 green:0.5 blue:0.8 alpha:1]];
            [controller release];
            return nav;
            break;
        }
        case 3:
        {
            UIViewController* controller= [[NGMoreViewController alloc] init];
            UINavigationController* nav=[[UINavigationController alloc] initWithRootViewController:controller];
            [nav.navigationBar setTintColor:[UIColor colorWithRed:0 green:0.5 blue:0.8 alpha:1]];
            
            [controller release];
            return nav;
            break;
        }
        default:
            break;
    }
    return nil;
    
}
-(void)tabView:(JMTabView *)tabView didSelectTabAtIndex:(NSUInteger)itemIndex;
{
    //[self.contentController loadScrollViewWithPage:itemIndex];
    
    self.pageControl.currentPage=itemIndex;
    
    [self changePage:nil];
    // NSLog(@"Selected Tab Index: %d", itemIndex);
}

@end
