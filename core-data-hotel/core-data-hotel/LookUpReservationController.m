//
//  LookUpReservationController.m
//  core-data-hotel
//
//  Created by Mike Miksch on 4/26/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "LookUpReservationController.h"
#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"
#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"
#import "Guest+CoreDataClass.h"
#import "Guest+CoreDataProperties.h"
#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"
#import "AppDelegate.h"
#import "AutoLayout.h"

@interface LookUpReservationController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) NSFetchedResultsController *allReservations;
@property(strong, nonatomic) UITableView *reservationsTableView;
@property(strong, nonatomic) UISearchBar *searchBar;
@property(strong, nonatomic) NSArray *filteredResults;
@property(strong, nonatomic) NSArray *allResults;

@end

@implementation LookUpReservationController



- (NSFetchedResultsController *)reservations {
    if (!_allReservations) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
        NSError *reservationFetchError;
        NSArray *results = [appDelegate.persistentContainer.viewContext executeFetchRequest:request error:&reservationFetchError];
        NSSortDescriptor *guestSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"guest.firstName" ascending:YES];
        request.sortDescriptors = @[guestSortDescriptor];
        NSError *reservationListError;
        
        _allReservations = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:appDelegate.persistentContainer.viewContext sectionNameKeyPath:nil cacheName:nil];
        
        [_allReservations performFetch:&reservationListError];
    }
    NSLog(@"%@", _allReservations);
    return _allReservations;
}

- (void)loadView {
    [super loadView];
    [self reservations];
    [self setupSearchBar];
    [self setupTable];
    [self setupViewLayout];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupSearchBar {
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate = self;
    [self.searchBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.searchBar];
}

-(void)setupTable {
    self.reservationsTableView = [[UITableView alloc]init];
    self.reservationsTableView.dataSource = self;
    [self.reservationsTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.reservationsTableView];
    [self.reservationsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}


-(void)setupViewLayout {
    CGFloat navBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    CGFloat statusBarHeight = 20.0;
    CGFloat topMargin = navBarHeight + statusBarHeight;
    CGFloat windowHeight = self.view.frame.size.height;
    CGFloat frameHeight = (windowHeight - topMargin - statusBarHeight);
    
    NSDictionary *viewDictionary = @{@"searchBar": self.searchBar,
                                     @"tableView": self.reservationsTableView};
    
    NSDictionary *metricsDictionary = @{@"topMargin": [NSNumber numberWithFloat:topMargin], @"frameHeight": [NSNumber numberWithFloat:frameHeight]};
    
    NSString *visualFormatString = @"V:|-topMargin-[searchBar][tableView]|";
    
    [AutoLayout leadingConstraintFrom:self.searchBar toView:self.view];
    [AutoLayout trailingConstraintFrom:self.searchBar toView:self.view];
    [AutoLayout leadingConstraintFrom:self.reservationsTableView toView:self.view];
    [AutoLayout trailingConstraintFrom:self.reservationsTableView toView:self.view];
    
    NSArray *constraints = [[NSArray alloc]init];
    
    NSArray *newConstraints = [NSLayoutConstraint constraintsWithVisualFormat:visualFormatString options:0 metrics:metricsDictionary views:viewDictionary];
    
    constraints = [constraints arrayByAddingObjectsFromArray:newConstraints];
    
    [NSLayoutConstraint activateConstraints:constraints];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.allResults = self.allReservations.fetchedObjects;
    self.filteredResults = self.allResults;
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.filteredResults count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Reservation *currentReservation = self.filteredResults[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [currentReservation.guest firstName], [currentReservation.guest lastName]];
    
    return cell;
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar isFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([self.searchBar.text isEqual:@""]) {
        self.filteredResults = self.allResults;
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.guest.firstName CONTAINS %@ OR self.guest.lastName CONTAINS %@", self.searchBar.text, self.searchBar.text];
        self.filteredResults = [self.allResults filteredArrayUsingPredicate:predicate];
    }
    
    [self.reservationsTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self.view endEditing:YES];
}



@end
