//
//  MPSTicker.h
//  RACTest
//
//  Created by Christopher Bowns on 12/17/13.
//  Copyright (c) 2013 Mechanical Pants. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

/// MPSTicker provides two signals:
/// A @c tick signal that increments a counter once per second
/// An @c enabled signal that allows @c tick to increase or hold value.

@interface MPSTicker : NSObject

- (RACSignal *)tickSignal;

- (RACSignal *)enabledSignal;

@end
