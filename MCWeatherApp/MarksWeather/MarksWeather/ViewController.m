//
//  ViewController.m
//  MarksWeather
//
//  Created by Mark Corrigan on 01/01/2015.
//  Copyright (c) 2015 MC. All rights reserved.
//


#import "ViewController.h"
#import "ViewController3.h"
#import "Weather.h"

@interface ViewController ()

@end

@implementation ViewController
{
    Weather *theWeather;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    theWeather = [[Weather alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GimmeWeather:(id)sender
{
    [theWeather getCurrent:self.LocationTextField.text];
    
    NSString *report = [NSString stringWithFormat:
                        @"The Weather in: \n"
                        @"\n"
                        @"%@-\n"
                        @"%@-\n"
                        @"Current temp : %2.1f C\n",
                        @"High: %2.1f C\n",
                        @"Low: %2.1f C\n",
                        theWeather.city,
                        theWeather.conditions[0][@"description"],
                        theWeather.tempCurrent,
                        theWeather.tempMax,
                        theWeather.tempMin
                        ];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Current Weather\n"
                                                    message:report
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)DayWeather:(id)sender
{
    [theWeather get5DayForecast:self.LocationTextField.text];
    
    
}
@end
