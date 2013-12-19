//
//  MPSViewModel.h
//  RACTest
//
//  Created by Christopher Bowns on 12/10/13.
//  Copyright (c) 2013 Mechanical Pants. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

// A ViewModel that models a timer ticking once per second to reflect value ticks since app launch.
// Also exposes a property to pause tick updates.

@interface MPSViewModel : NSObject

/// The tick string.
@property (nonatomic, strong, readonly) NSString *tickString;

/// A @c BOOL that controls whether the time string is being updated.
//@property (nonatomic, assign, getter = isPaused) BOOL paused;

@end
