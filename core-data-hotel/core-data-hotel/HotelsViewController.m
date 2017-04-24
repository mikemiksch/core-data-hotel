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

@interface HotelsViewController ()

@property(strong, nonatomic) NSArray *allHotels;

@property(strong, nonatomic) UITableView *hotelTableView;

@end

@implementation HotelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
