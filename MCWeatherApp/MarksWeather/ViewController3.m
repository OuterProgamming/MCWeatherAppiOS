//
//  ViewController3.m
//  MarksWeather
//
//  Created by Mark Corrigan on 02/01/2015.
//  Copyright (c) 2015 MC. All rights reserved.
//

#import "ViewController3.h"
#import "Weather.h"


@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.WeatherDays = @[@"Day1",
                        @"Day2",
                        @"Day3",
                        @"Day4",
                        @"Day5"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfCellsInTableView:(UITableView *)tableView
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.WeatherDays count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *SimpleIdenifier = @"SimpleIdenifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdenifier];
    
   if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SimpleIdenifier];
    }
    
    //Hoping to Make an If Statement to have different Logos appear Depending on what the Weather is going to be
    //but incase I run out of Time seen as I cant seem to get the JSON Info to Work I just put in the an Image as
    //a place holder.
    UIImageView *imageView = [[UIImageView alloc]
    initWithImage:[UIImage imageNamed:@"LogoSmall.png"]];
    cell.accessoryView = imageView;
    
   
    cell.textLabel.text = self.WeatherDays[indexPath.row];
    
    return cell;
}

@end
