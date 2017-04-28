//
//  HotelServiceTest.m
//  core-data-hotel
//
//  Created by Mike Miksch on 4/27/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HotelService.h"
#import "Guest+CoreDataProperties.h"
#import "Guest+CoreDataClass.h"


@interface HotelServiceTest : XCTestCase

@property(strong, nonatomic) NSDate *startDate;
@property(strong, nonatomic) NSDate *endDate;
@property(strong, nonatomic) Guest *testGuest;
@property(strong, nonatomic) Room *testRoom;
@property(strong, nonatomic) AppDelegate *appDelegate;
@property(strong, nonatomic) NSManagedObjectContext *context;


@end

@implementation HotelServiceTest

- (void)setUp {
    [super setUp];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSDateComponents *dayComponent = [[NSDateComponents alloc]init];
    dayComponent.day = 1;
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    
    NSDate *startDate = [NSDate date];
    NSDate *endDate = [theCalendar dateByAddingComponents:dayComponent toDate:startDate options:0];
    Guest *testGuest = [[Guest alloc]init];
    testGuest.firstName = @"Test";
    testGuest.lastName = @"Also Test";
    testGuest.email = @"email at email";
    
    Room *testRoom = [[Room alloc]init];
    
}

- (void)tearDown {
    self.startDate = nil;
    self.endDate = nil;
    self.testGuest = nil;
    self.appDelegate = nil;
    self.context = nil;
    [super tearDown];
}

+ (void)testCheckAvailabilityStartDateToAppDelegateContext {
    id availabilityCheck = [HotelService checkAvailability:self.startDate to:self.endDate appDelegate:appDelegate context:context];
    
    XCTAssert([availabilityCheck isKindOfClass:[NSFetchedResultsController class]], @"availabilityCheck is not an instance of NSFetchedResultsController");
    XCTAssertGreaterThan(self.endDate, self.startDate);
    
}

+ (void)testMakeReservationStartDateToEndDateInRoomForAppDelegateContext {
    id reservationBooking = [HotelService makeReservation:self.startDate to:self.endDate in:self.room for:guest appDelegate:appDelegate context:context];
    
    XCTAssert([reservationBooking.reservation isKind])
    
}

@end
