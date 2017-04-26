//
//  HotelTest.m
//  core-data-hotel
//
//  Created by Mike Miksch on 4/26/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"

@interface HotelTest : XCTestCase

@property(strong, nonatomic) Hotel *testHotel;

@end

@implementation HotelTest

- (void)setUp {
    [super setUp];
    self.testHotel = [[Hotel alloc]init];
}

- (void)tearDown {
    self.testHotel = nil;
    [super tearDown];
}

- (void) testHotelProperties {
    XCTAssert(self.testHotel.location, @"Hotel does not have a location property!");
    XCTAssert(self.testHotel.name, @"Hotel does not have a name property!");
    XCTAssert(self.testHotel.stars, @"Hotel does not have a stars property!");
    XCTAssert(self.testHotel.rooms, @"Hotel does not have a rooms property!");
    
}


@end
