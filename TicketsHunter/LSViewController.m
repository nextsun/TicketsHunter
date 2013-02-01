//
//  LSViewController.m
//  TicketsHunter
//
//  Created by Lei Sun on 1/28/13.
//  Copyright (c) 2013 EasyTeam. All rights reserved.
//

#import "LSViewController.h"

@interface LSViewController ()

@end

@implementation LSViewController


- (id)init
{
    self = [super init];
    if (self) {
        
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    
//    UIWebView* webView=[[UIWebView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:webView];
//    
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
     content=[[NGContentController alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:content.view];
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [content release];
    [super dealloc];
}

@end
