//
//  CBDetailViewController.m
//  courseBustr
//
//  Created by Ke Yang on 12/28/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import "CBDetailViewController.h"
#import "CBDataSingleton.h"
#import "CBCourseModel.h"
#import "CBPageContentViewController.h"

@interface CBDetailViewController ()

@end

@implementation CBDetailViewController

@synthesize row;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pageContentID = @[@"pageContentInfo", @"pageContentChart", @"pageContentList"];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pageViewController"];
    self.pageViewController.dataSource = self;
    
    UIViewController* initialPage = [self viewControllerAtIndex:0];
    NSArray* viewControllers = @[initialPage];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    //self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    CBDataSingleton* sharedData = [CBDataSingleton sharedData];
    CBCourseModel* course = sharedData.courseList[self.row];
    self.title = course.CID;
//    [self.labelName setText:course.name];
//    [self.labelCID setText:course.CID];
//    [self.labelCRN setText:[NSString stringWithFormat:@"%d", course.CRN]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)editViewControllerDidCancel:(id)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)editViewControllerDidDone:(id)controller withCourseModel:(CBCourseModel *)course
{
    CBDataSingleton* sharedData = [CBDataSingleton sharedData];
    CBCourseModel * c = sharedData.courseList[self.row];
    c.name = course.name;
    c.CID = course.CID;
    c.CRN = course.CRN;
    c.color = course.color;
    self.title = course.CID;
//    [self.labelName setText:course.name];
//    [self.labelCID setText:course.CID];
//    [self.labelCRN setText:[NSString stringWithFormat:@"%d", course.CRN]];
    [self.delegate updateCellAtRow:self.row];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"editCourse"]) {
        UINavigationController* navController = segue.destinationViewController;
        CBEditViewController* editController = [[navController viewControllers] objectAtIndex:0];
        editController.row = self.row;
        editController.delegate = self;
    }
}

- (UIViewController*)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageContentID count]==0) || (index >= [self.pageContentID count])) {
        return nil;
    }
    CBPageContentViewController* pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:self.pageContentID[index]];
    pageContentViewController.pageIndex = index;
    pageContentViewController.row = self.row;
    return pageContentViewController;
}


#pragma mark - page View controller data source
- (UIViewController*)pageViewController:(UIPageViewController *)pageViewController
     viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((CBPageContentViewController*) viewController).pageIndex;
    if ((index==0) || (index==NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController*)pageViewController:(UIPageViewController *)pageViewController
      viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((CBPageContentViewController*) viewController).pageIndex;
    if (index==NSNotFound) {
        return nil;
    }
    
    index++;
    
    if (index==[self.pageContentID count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageContentID count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


@end
