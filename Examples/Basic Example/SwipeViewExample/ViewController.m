//
//  ViewController.m
//  SwipeViewExample
//
//  Created by Nick Lockwood on 28/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *colors;

@end


@implementation ViewController

@synthesize swipeView = _swipeView;
@synthesize pageControl = _pageControl;
@synthesize colors = _colors;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        //set up colors
        self.colors = [NSMutableArray array];
        for (int i = 0; i < 3; i++)
        {
            [self.colors addObject:[UIColor colorWithRed:rand()/(float)RAND_MAX
                                                   green:rand()/(float)RAND_MAX
                                                    blue:rand()/(float)RAND_MAX
                                                   alpha:1.0f]];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configure swipe view
    _swipeView.alignment = SwipeViewAlignmentCenter;
    _swipeView.pagingEnabled = YES;
    _swipeView.wrapEnabled = NO;
//    _swipeView.itemsPerPage = 3;
//    _swipeView.truncateFinalPage = YES;

    //configure page control
    _pageControl.numberOfPages = _swipeView.numberOfPages;
    _pageControl.defersCurrentPageDisplay = YES;

    //
    _swipeView.itemAlpha = 0.5f;
    _swipeView.itemScale = 0.8f;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return [self.colors count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = (UILabel *)view;
    
    //create or reuse view
    if (view == nil)
    {
        label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 200.0f)] autorelease];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        view = label;
    }
    
    //configure view
    label.backgroundColor = (self.colors)[index];
    label.text = [NSString stringWithFormat:@"%i", index];
    
    //return view
    return view;
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    //update page control page
    _pageControl.currentPage = swipeView.currentPage;
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"Selected item at index %i", index);
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView {
    return CGSizeMake(200.0f, 200.0f);
}

- (IBAction)pageControlTapped
{
    //update swipe view page
    [_swipeView scrollToPage:_pageControl.currentPage duration:0.4];
}

- (void)dealloc
{
    [_swipeView release];
    [_colors release];
    [super dealloc];
}

@end
