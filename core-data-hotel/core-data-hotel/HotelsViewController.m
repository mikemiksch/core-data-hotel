//
//  HotelsViewController.m
//  core-data-hotel
//
//  Created by Mike Miksch on 4/24/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "HotelsViewController.h"
#import "AppDelegate.h"

#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"

@interface HotelsViewController ()<UITableViewDataSource>

@property(strong, nonatomic) NSArray *allHotels;

@property(strong, nonatomic) UITableView *hotelsTableView;

@end

@implementation HotelsViewController


- (void)loadView {
    [super loadView];
        //add hotelsTableView as subview and apply constraints
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hotelsTableView.dataSource = self;
    [self.hotelsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];




}

- (NSArray *)allHotels {
    if (!_allHotels) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotels"];
        
        NSError *fetchError;
        NSArray *hotels = [context executeFetchRequest:request error:&fetchError];
        
        if (fetchError) {
            NSLog(@"There was an error fetching hotels from Core Data!");
        }
        
        _allHotels = hotels;
        
    }
    
    return _allHotels;
    
}


@end
