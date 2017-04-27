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


@end
