//
//  calculatorbrain.m
//  NewCalculator
//
//  Created by Navid on 4/20/13.
//  Copyright (c) 2013 Navid. All rights reserved.
//

#import "calculatorbrain.h"

@interface calculatorbrain ()
@property (strong, nonatomic) NSMutableArray *operandStack;

@end

@implementation calculatorbrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *) operandStack
{
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

- (void) pushOperand : (double) operand
{
    NSObject *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

- (double) popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) {
        [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
}
- (double) performOperation : (NSString *) operation
{
    double result = 0;
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([@"-" isEqualToString:operation]) {
        double minoperand = [self popOperand];
        result = [self popOperand] - minoperand;
    } else if ([@"/" isEqualToString:operation]) {
        double divisor = [self popOperand];
        result = [self popOperand] / divisor;
    }
    [self pushOperand:result];
    return result;
}

@end
