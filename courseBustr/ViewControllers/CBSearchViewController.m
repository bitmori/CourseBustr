//
//  CBSearchViewController.m
//  courseBustr
//
//  Created by Ke Yang on 1/9/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "CBSearchViewController.h"

@interface CBSearchViewController ()

@property (strong, nonatomic) NSString* CID;
@property (strong, nonatomic) NSString* Name;
@property (strong, nonatomic) NSMutableArray* searchResult;
@property (assign, nonatomic) BOOL shouldReloadOnAppear;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)onCancelButton:(id)sender;

@end

@implementation CBSearchViewController

@synthesize CID;
@synthesize Name;
@synthesize searchResult;
@synthesize shouldReloadOnAppear;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.parseClassName = @"UIUC_courses";
        self.pullToRefreshEnabled = NO;
        self.paginationEnabled = NO;
        self.objectsPerPage = 10;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.searchBar becomeFirstResponder];
    [self.searchBar setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchResult removeAllObjects];
    [self.searchBar resignFirstResponder];
    searchResult = [NSMutableArray arrayWithCapacity:10];
    PFQuery* query = [PFQuery queryWithClassName:@"UIUC_courses"];
    query.cachePolicy = kPFCachePolicyNetworkOnly;
    query.limit = 10;
    if (self.searchBar.selectedScopeButtonIndex==0) {
        // CID
//        PFQuery* qCid = [PFQuery queryWithClassName:@"UIUC_courses"];
//        [qCid whereKey:@"dept" containsString:@""];
//        PFQuery* qNum = [PFQuery queryWithClassName:@"UIUC_courses"];
//        [qNum whereKey:@"" containsAllObjectsInArray:@[]];
        [query whereKey:@"dept" containsString:searchBar.text];
    } else if (self.searchBar.selectedScopeButtonIndex==1) {
        // Name
        [query whereKey:@"name" containsString:searchBar.text];
    }
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [searchResult addObjectsFromArray:objects];
        } else {
            NSString* errString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error!! %@", errString);
        }
        //[searchResult addObjectsFromArray:objects];
        //NSLog(@"__%d", [objects count]);
        //[query orderByAscending:@""];
    }];
    [self loadObjects];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [searchResult count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"searchCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if ([searchResult count]==0) {
        //return nutshell cell;
    } else {
        //PFObject* obj = [PFObject objectWithClassName:@"UIUC_courses"];
        PFObject* obj = searchResult[indexPath.row];
        NSString* _CID = [[NSString alloc] initWithFormat:@"%@ %@", obj[@"dept"], obj[@"number"]];
        [cell.textLabel setText:_CID];
        [cell.detailTextLabel setText:obj[@"name"]];
    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addCourse"]) {
        UINavigationController* navController = segue.destinationViewController;
        CBEditCourseViewController* addController = [[navController viewControllers] objectAtIndex:0];
        
        NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
        addController.courseInfo = self.searchResult[indexPath.row];
        addController.editMode = NO;
        addController.delegate = self.delegate;
    }
}

- (IBAction)onCancelButton:(id)sender {
    [self.delegate searchViewControllerDidCancel:self];
}

@end
