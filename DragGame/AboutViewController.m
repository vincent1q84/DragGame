//
//  AboutViewController.m
//  DragGame
//
//  Created by AIR on 13-12-27.
//  Copyright (c) 2013年 AIR. All rights reserved.
//

#import "AboutViewController.h"
 
@interface AboutViewController ()
- (IBAction)close:(id)sender;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation AboutViewController
@synthesize webView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSURL *url = [NSURL URLWithString:@"http://9.douban.com/site/entry/693619378/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
