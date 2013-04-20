//
//  calculatorViewController.m
//  NewCalculator
//
//  Created by Navid on 4/19/13.
//  Copyright (c) 2013 Navid. All rights reserved.
//

#import "calculatorViewController.h"
#import "calculatorbrain.h"

@interface calculatorViewController ()
@property (nonatomic) BOOL UserInTheMiddleOfTypping;
@property (strong, nonatomic) calculatorbrain *brain;
@property (strong, nonatomic) NSString *currentOperation;
@end

@implementation calculatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@synthesize Display;
@synthesize UserInTheMiddleOfTypping;
@synthesize brain = _brain;
@synthesize currentOperation = _currentOperation;

- (calculatorbrain *) brain
{
    if (!_brain) {
        _brain = [[calculatorbrain alloc] init];
    }
    return _brain;
}
- (NSString *) currentOperation
{
    if (!_currentOperation) {
        _currentOperation = [[NSString alloc] init];
    }
    return _currentOperation;
}
- (IBAction)pressedOperand:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (self.UserInTheMiddleOfTypping) {
        self.Display.text = [self.Display.text stringByAppendingString:digit];
    } else {
        self.Display.text = digit;
        self.UserInTheMiddleOfTypping = YES;
    }
}
- (IBAction)EnterPressed {
    [self.brain pushOperand:[self.Display.text doubleValue]];
    self.UserInTheMiddleOfTypping = NO;
}

- (IBAction)OperationPressed:(UIButton *)sender {
    if (UserInTheMiddleOfTypping) {
        [self EnterPressed];
    }
    self.currentOperation = [sender currentTitle];
    self.Display.text = [NSString stringWithFormat:@"%g" ,[self.brain performOperation: self.currentOperation]];

   
}

- (IBAction)PiConstant:(UIButton *)sender {
    double Pi = 3.1415;
    self.Display.text = [NSString stringWithFormat:@"%g", Pi];

}

- (IBAction)Clear {
    self.Display.text = 0;
    self.currentOperation = Nil;
    [self.brain pushOperand:[self.Display.text doubleValue]];
    self.UserInTheMiddleOfTypping = NO;
}
@end
