//
//  CalculatorBrain.h
//  NewCalculator
//
//  Created by Navid on 4/20/13.
//  Copyright (c) 2013 Navid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)op;

@property (nonatomic, readonly) id program;

+ (NSString *)descriptionOfProgram:(id)program;
+ (double)runProgram:(id)program;

@end
