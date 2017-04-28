//
//  AutoLayoutTest.m
//  core-data-hotel
//
//  Created by Mike Miksch on 4/26/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AutoLayout.h"

@interface AutoLayoutTest : XCTestCase

@property(strong, nonatomic) UIViewController *testController;
@property(strong, nonatomic) UIView *testView1;
@property(strong, nonatomic) UIView *testView2;

@end

@implementation AutoLayoutTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.testController = [[UIViewController alloc]init];
    self.testView1 = [[UIView alloc]init];
    self.testView2 = [[UIView alloc]init];
    
    [self.testController.view addSubview:self.testView1];
    [self.testController.view addSubview:self.testView2];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    self.testController = nil;
    self.testView1 = nil;
    self.testView2 = nil;
    
    [super tearDown];
}


- (void)testGenericConstraintFromToViewWithAttribute {
    
    XCTAssertNotNil(self.testController, @"The testController is nil!");
    XCTAssertNotNil(self.testView1, @"TestView1 is nil!");
    XCTAssertNotNil(self.testView2, @"TestView2 is nil!");
    
    id constraint = [AutoLayout genericConstraintFrom:self.testView1 toView:self.testView2 withAttribute:NSLayoutAttributeTop];
    
    XCTAssert([constraint isKindOfClass:[NSLayoutConstraint class]], @"constraint is not an instance of NSLayoutConstraint");
    
    XCTAssert([(NSLayoutConstraint *)constraint isActive], @"constraint was not activated");
    
}

//Tests written for lab

- (void)testGenericConstraintFromViewToViewWithAttributeAndMultiplier {
    
    id constraint = [AutoLayout genericConstraintFrom:self.testView1 toView:self.testView2 withAttribute:NSLayoutAttributeTop andMultiplier:1.0];
    
    XCTAssert([constraint isKindOfClass:[NSLayoutConstraint class]], @"constraint is not an instance of NSLayoutConstraint");
    XCTAssertTrue([(NSLayoutConstraint *)constraint isActive], @"constraint was not activated");
}

- (void)testGenericConstraintFromViewToViewWithAttributeAndConstant {
    
    id constraint = [AutoLayout genericConstraintFrom:self.testView1 toView:self.testView2 withAttribute:NSLayoutAttributeTop andConstant:1.0];

    XCTAssert([constraint isKindOfClass:[NSLayoutConstraint class]], @"constraint is not an instance of NSLayoutConstraint");
    XCTAssert([(NSLayoutConstraint *)constraint isActive], @"constraint was not activated");
}

- (void)testFullScreenContraintsWithVFLForView {
    
    //Method logic
    NSMutableArray *constraints = [[NSMutableArray alloc]init];
    NSDictionary *viewDictionary = @{@"view": self.testView1};
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|"
                                                                            options:0
                                                                             metrics:nil
                                                                               views:viewDictionary];
    
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewDictionary];
    
    [constraints addObjectsFromArray:horizontalConstraints];
    [constraints addObjectsFromArray:verticalConstraints];
    
    [NSLayoutConstraint activateConstraints:constraints];
    
    XCTAssert([constraints isKindOfClass:[NSMutableArray class]], @"constraints is not an instance of NSMutableArray");
    XCTAssert([viewDictionary isKindOfClass:[NSDictionary class]], @"viewDictionary is not an instance of NSDictionary");
    XCTAssert([horizontalConstraints isKindOfClass:[NSArray class]], @"horizontalConstraints is not an instance of NSArray");
    XCTAssert([verticalConstraints isKindOfClass:[NSArray class]], @"verticalConstraints is not an instance of NSArray");
    XCTAssert([constraints[0] isKindOfClass:[NSLayoutConstraint class]], @"horizontalConstraints is not an instance of NSLayoutConstraint");
    XCTAssert([constraints[1] isKindOfClass:[NSLayoutConstraint class]], @"verticalConstraints is not an instance of NSLayoutConstraint");
    XCTAssert([constraints[0] isActive], @"horizontalConstraints is not active");
    XCTAssert([constraints[1] isActive], @"verticalConstraints is not active");
    
}

- (void)testEqualHeightConstraintFromViewToViewWithMultiplier {
    
    id constraint = [AutoLayout equalHeightConstraintFromView:self.testView1 toView:self.testView2 withMultiplier:1.0];
    XCTAssert([constraint isKindOfClass:[NSLayoutConstraint class]], @"constraint is not an instance of NSLayoutConstraint");
    XCTAssert([(NSLayoutConstraint *)constraint isActive], @"constraint was not activated");
}

- (void)testLeadingConstraintFromToView {
    
    id constraint = [AutoLayout leadingConstraintFrom:self.testView1 toView:self.testView2];
    XCTAssert([constraint isKindOfClass:[NSLayoutConstraint class]], @"constaint is not an instance of NSLayoutConstraint");
    XCTAssert([(NSLayoutConstraint *)constraint isActive], @"constraint was not activated");
}

@end
