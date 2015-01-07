//
//  ViewController.h
//  MarksWeather
//
//  Created by Mark Corrigan on 01/01/2015.
//  Copyright (c) 2015 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *LocationTextField;

- (IBAction)GimmeWeather:(id)sender;
- (IBAction)DayWeather:(id)sender;

@end

