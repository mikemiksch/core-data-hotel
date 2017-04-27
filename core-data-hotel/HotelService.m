//
//  HotelService.m
//  core-data-hotel
//
//  Created by Mike Miksch on 4/27/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "HotelService.h"
#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"
#import <Crashlytics/Crashlytics.h>

@implementation HotelService

+ (void)makeReservation:(NSDate *)startDate to:(NSDate *)endDate in:(Room *)room for:(Guest *)guest appDelegate:(AppDelegate *)appDelegate context:(NSManagedObjectContext *)context {
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:context];
    
    reservation.startDate = startDate;
    reservation.endDate = endDate;
    reservation.room = room;
    reservation.guest = guest;
    
    room.reservation = [room.reservation setByAddingObject:reservation];

    NSError *saveError;
    [context save:&saveError];
    
    if (saveError) {
        NSLog(@"Reservation saving error");
        [Answers logCustomEventWithName:@"Reservation saving error" customAttributes:nil];
    } else {
        NSLog(@"Reservation saved successfully");
        [Answers logCustomEventWithName:@"Reservation saved successfully" customAttributes:nil];
    }
    
    
}

+ (NSFetchedResultsController *)checkAvailability:(NSDate *)startDate to:(NSDate *)endDate appDelegate:(AppDelegate *)appDelegate context:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    request.predicate = [NSPredicate predicateWithFormat:@"startDate <=  %@ AND endDate >= %@", endDate, startDate];
    
    NSError *roomError;
    NSArray *results = [context executeFetchRequest:request error:&roomError];
    
    NSMutableArray *unavailableRooms = [[NSMutableArray alloc]init];
    
    for (Reservation *reservation in results) {
        [unavailableRooms addObject:reservation.room];
    }
    
    NSFetchRequest *roomRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
    roomRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
    
    NSSortDescriptor *roomSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"hotel.name" ascending:YES];
    
    NSSortDescriptor *roomNumberSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];
    
    roomRequest.sortDescriptors = @[roomSortDescriptor, roomNumberSortDescriptor];
    
    NSError *availableRoomError;
    
    NSFetchedResultsController *rooms = [[NSFetchedResultsController alloc] initWithFetchRequest:roomRequest managedObjectContext:context sectionNameKeyPath:@"hotel.name" cacheName:nil];
    
    [rooms performFetch:&availableRoomError];
    
    return rooms;
    
}


@end
