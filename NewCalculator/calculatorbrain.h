//
//  calculatorbrain.h
//  NewCalculator
//
//  Created by Navid on 4/20/13.
//  Copyright (c) 2013 Navid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface calculatorbrain : NSObject

- (void) pushOperand : (double) operand;
- (double) performOperation : (NSString *) operation;
- (double) backSpace;

@end
