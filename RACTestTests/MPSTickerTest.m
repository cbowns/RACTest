//
//  MPSTickerTest.m
//  RACTest
//
//  Created by Christopher Bowns on 1/31/14.
//  Copyright (c) 2014 Mechanical Pants. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MPSTicker.h"

@interface MPSTickerTest : XCTestCase

@end

@implementation MPSTickerTest

- (void)setUp
{
	[super setUp];
	// Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
	// Put teardown code here; it will be run once, after the last test case.
	[super tearDown];
}

#pragma mark - Tests

#pragma mark Initialization

- (void)testDefaultInitialization
{
	MPSTicker *ticker = [[MPSTicker alloc] init];
	XCTAssertTrue(ticker.accumulateEnabled, @"Ticker accumulation should be enabled after initialization.");
	RACSignal *accumulateSignal = ticker.accumulateSignal;
	XCTAssertNotNil(accumulateSignal, @"Accumulate signal should be an object");
	XCTAssertTrue([[accumulateSignal class] isSubclassOfClass:[RACSignal class]], @"Accumulate signal should be a RACSignal.");
}

- (void)testDesignatedInitializer
{
	RACSignal *controlledTick = [[RACSignal alloc] startWith:@(0)];
	MPSTicker *ticker = [[MPSTicker alloc] initWithTickSource:controlledTick];
	RACSignal *tickSignal = ticker.accumulateSignal;
	XCTAssertNotNil(tickSignal, @"Accumulate signal should be an object");
	XCTAssertTrue([[tickSignal class] isSubclassOfClass:[RACSignal class]], @"Accumulate signal should be a RACSignal.");
}

@end
