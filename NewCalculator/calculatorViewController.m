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
@property (strong, nonatomic) CalculatorBrain *brain;
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
@synthesize Description;

- (CalculatorBrain *) brain
{
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}
- (IBAction)BackSpace {
    if (UserInTheMiddleOfTypping) {
        int DisplayLength = [self.Display.text length] -1 ;
        self.Display.text = [self.Display.text substringToIndex: DisplayLength];
        DisplayLength = [self.Description.text length] -1 ;
        self.Description.text = [self.Description.text substringToIndex: DisplayLength];
    }
}

- (NSString *) currentOperation
{
    if (!_currentOperation) {
        _currentOperation = [[NSString alloc] init];
    }
    return _currentOperation;
}
- (void) DisplayDescription : (NSString *) descriptionText
{
    self.Description.text = [self.Description.text stringByAppendingString:descriptionText];
}
- (IBAction)pressedOperand:(UIButton *)sender {
    // this part adds pressed operand button as a digit to the number
    NSString *digit = [sender currentTitle];
    if (self.UserInTheMiddleOfTypping) {
        // this if statement removes 0 from the starting point of number
        if ([digit isEqualToString:@"."]) {
        // this part protects calculator from getting unavalable decimal number
            NSRange range = [self.Display.text rangeOfString:@"."];
        if (range.location == NSNotFound)
            self.Display.text = [self.Display.text stringByAppendingString: digit];
        } else self.Display.text = [self.Display.text stringByAppendingString: digit];
    } else {
        self.Display.text = digit;
        self.UserInTheMiddleOfTypping = YES;
    }
    [self DisplayDescription: digit];
}
- (IBAction)EnterPressed {
    [self.brain pushOperand:[self.Display.text doubleValue]];
    self.UserInTheMiddleOfTypping = NO;
    [self DisplayDescription: @" "];
}

- (IBAction)OperationPressed:(UIButton *)sender {
    if (UserInTheMiddleOfTypping) [self EnterPressed];
    self.currentOperation = [sender currentTitle];
    [self DisplayDescription: [self.currentOperation stringByAppendingString:@" "]];
    self.Display.text = [NSString stringWithFormat:@"%g" ,[self.brain performOperation: self.currentOperation]];
}
- (IBAction)Clear {
    self.Display.text = [NSString stringWithFormat:@"%d", 0];
    self.currentOperation = Nil;
    [self.brain pushOperand:[self.Display.text doubleValue]];
    self.UserInTheMiddleOfTypping = NO;
    self.Description.text = [NSString stringWithFormat:@" ", nil];
}


@end
