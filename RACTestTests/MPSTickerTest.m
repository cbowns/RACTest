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
	RACSignal *customTick = [[RACSignal alloc] startWith:@(0)];
	MPSTicker *ticker = [[MPSTicker alloc] initWithTickSource:customTick];
	RACSignal *tickSignal = ticker.accumulateSignal;
	XCTAssertNotNil(tickSignal, @"Accumulate signal should be an object");
	XCTAssertTrue([[tickSignal class] isSubclassOfClass:[RACSignal class]], @"Accumulate signal should be a RACSignal.");
}

- (void)testFirstTickValue
{
	// Create a custom tick with one value to send.
	NSUInteger firstValue = 1;
	RACSignal *customTick = [[@[@(firstValue)] rac_sequence] signal];
	MPSTicker *ticker = [[MPSTicker alloc] initWithTickSource:customTick];

	// Manually subscribe to verify we got back the value we expected.
	// (It should be one accumulated value.)
	BOOL success = NO;
	NSError *error = nil;
	id value = [ticker.accumulateSignal asynchronousFirstOrDefault:nil success:&success error:&error];
	if (!success) {
		XCTAssertTrue(success, @"Signal failed to return a value. Error: %@", error);
	} else {
		XCTAssertNotNil(value, @"Signal returned a nil value.");
		XCTAssertEqualObjects(@(firstValue), value, @"Signal returned an unexpected value.");
	}
}

/// Tests the default ticker's built-in timer.
/// This test takes a second to run as a result.
- (void)testTimerAccumulatingTicks
{
	NSUInteger firstValue = 1;
	MPSTicker *ticker = [[MPSTicker alloc] init];

	BOOL success = NO;
	NSError *error = nil;
	id value = [ticker.accumulateSignal asynchronousFirstOrDefault:nil success:&success error:&error];
	if (!success) {
		XCTAssertTrue(success, @"Signal failed to return a value. Error: %@", error);
	} else {
		XCTAssertNotNil(value, @"Signal returned a nil value.");
		XCTAssertEqualObjects(@(firstValue), value, @"Signal returned an unexpected value of %@, should be %i", value, firstValue);
	}
}

@end
