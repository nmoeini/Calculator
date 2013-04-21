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
@synthesize Description;

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
- (void) DisplayDescription : (NSString *) descriptionText
{
    self.Description.text = [self.Description.text stringByAppendingString:descriptionText];
}
- (IBAction)pressedOperand:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (self.UserInTheMiddleOfTypping) {
        self.Display.text = [self.Display.text stringByAppendingString: digit];
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
    if (UserInTheMiddleOfTypping) {
        [self EnterPressed];
    }
    self.currentOperation = [sender currentTitle];
    [self DisplayDescription: [self.currentOperation stringByAppendingString:@" "]];
    self.Display.text = [NSString stringWithFormat:@"%g" ,[self.brain performOperation: self.currentOperation]];
}
- (IBAction)Clear {
    self.Display.text = [NSString stringWithFormat:@"%d", 0];
    self.currentOperation = Nil;
    [self.brain pushOperand:[self.Display.text doubleValue]];
    self.UserInTheMiddleOfTypping = NO;
    self.Description.text = [NSString stringWithFormat:@"%d", 0];
}

- (IBAction)BackSpace {
    
}
@end
