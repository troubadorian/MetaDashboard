//
//  AskerViewController.m
//  MetaDashBoard
//
//  Created by  on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AskerViewController.h"

@interface AskerViewController ()<UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UILabel *questionLabel;

@property (strong, nonatomic) IBOutlet UITextField *answerTextField;

@end

@implementation AskerViewController
@synthesize questionLabel = _questionLabel;
@synthesize answerTextField = _answerTextField;

@synthesize question = _question;
@synthesize answer = _answer;

@synthesize delegate = _delegate;


- (void) setQuestion:(NSString *)question
{
	_question = question;
	self.questionLabel.text = question;
	
}





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

		self.questionLabel.text = self.question;
	
	self.answerTextField.placeholder = self.answer;
	
	self.answerTextField.delegate = self;
	

}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.answerTextField becomeFirstResponder];
}

- (void)viewDidUnload
{
	[self setQuestionLabel:nil];
	[self setAnswerTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  
	
	return YES;
}

#pragma mark UITextFieldDelegate

- (void) textFieldDidEndEditing:(UITextField *)textField
{
	self.answer = textField.text;
	
	if (![textField.text length])
	{
		[[self presentingViewController] dismissModalViewControllerAnimated:YES];
	}
	else 
	{
		// need to communicate
		[self.delegate askerViewController:self didAskQuestion:self.question	andGotAnswer:self.answer];
	}
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
	if ([textField.text length])
		 {
			 [textField resignFirstResponder];
			 return YES;
		 }
	else 
	{
		return NO;
	}
}

@end
