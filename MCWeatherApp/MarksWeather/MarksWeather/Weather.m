//
//  Weather.m
//  MarksWeather
//
//  Created by Mark Corrigan on 01/01/2015.
//  Copyright (c) 2015 MC. All rights reserved.
//

#import "Weather.h"
#import "ViewController3.h"
#import "AFNetworking.h"


@implementation Weather {
    NSDictionary *weatherServiceResponse;
}

- (id)init
{
    self = [super init];
    
    weatherServiceResponse = @{};
    
    return self;
}

- (void)getCurrent:(NSString *)query
{
    NSString *const BASE_URL_STRING = @"http://api.openweathermap.org/data/2.5/weather";
    
    NSString *weatherURLText = [NSString stringWithFormat: @"%@?q=%@", BASE_URL_STRING, query];
 
    NSURL *weatherURL = [NSURL URLWithString:weatherURLText];
    NSURLRequest *weatherRequest = [NSURLRequest requestWithURL:weatherURL];
    
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:weatherRequest];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //NSURLRequest *weatherRequest, NSHTTPURLResponse *response, id JSON);
         //weatherServiceResponse = (NSDictionary *)JSON;
         weatherServiceResponse = (NSDictionary *)responseObject;
         [self parseWeatherServiceResponse];
     }
     
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                     {
                                         weatherServiceResponse = @{};
                                     }
     ];
    
    [operation start];
}


// 5 Day Forecast Method
// I Just checked my API Key and for Reason it says Im from Moscow in Russia!?
// Mightn't get this Working/Finished! A bit confused.
// OpenWeather - My Forecast API KEY: http://api.openweathermap.org/data/2.5/forecast/city?id=524901&APPID=97127a3532a54c511a2ca8128d3c4a13


- (void)get5DayForecast:(NSString *)query
{
    NSString *const BASE_URL_STRING = @"http://api.openweathermap.org/data/2.5/forecast/city?id=524901&APPID=97127a3532a54c511a2ca8128d3c4a13";
    
    NSString *weatherURLText = [NSString stringWithFormat: @"%@?q=%@", BASE_URL_STRING, query];
    
    NSURL *weatherURL = [NSURL URLWithString:weatherURLText];
    NSURLRequest *weatherRequest = [NSURLRequest requestWithURL:weatherURL];
    
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:weatherRequest];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *myDic = (NSDictionary *)responseObject;
         NSMutableArray *WeatherDays = [myDic objectForKey:@"weather"];
         NSString *entry = [WeatherDays objectAtIndex:0];
         NSLog(@"%@", entry);
         
         int i;
         
         for (i = 0; i < [WeatherDays count]; i++)
         {
             entry = [WeatherDays objectAtIndex:i];
             NSLog(@"%@", entry);
         }
         
     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failure"
                                                         message:[error localizedDescription]
                                                        delegate:nil
                                               cancelButtonTitle:@"Try Again"
                                               otherButtonTitles:nil];
         [alert show];
     }];
    
    [operation start];
}


- (void)parseWeatherServiceResponse
{
    // clouds
    _cloudCover = [weatherServiceResponse[@"clouds"][@"all"] integerValue];
    
    // coord
    _latitude = [weatherServiceResponse[@"coord"][@"lat"] doubleValue];
    _longitude = [weatherServiceResponse[@"coord"][@"lon"] doubleValue];
    
    // dt
    _reportTime = [NSDate dateWithTimeIntervalSince1970:[weatherServiceResponse[@"dt"] doubleValue]];
    
    // main
    _humidity = [weatherServiceResponse[@"main"][@"humidity"] integerValue];
    _pressure = [weatherServiceResponse[@"main"][@"pressure"] integerValue];
    _tempCurrent = [Weather kelvinToCelsius:[weatherServiceResponse[@"main"][@"temp"] doubleValue]];
    _tempMin = [Weather kelvinToCelsius:[weatherServiceResponse[@"main"][@"temp_min"] doubleValue]];
    _tempMax = [Weather kelvinToCelsius:[weatherServiceResponse[@"main"][@"temp_max"] doubleValue]];
    
    // name
    _city = weatherServiceResponse[@"name"];
    
    // rain
    _rain3hours = [weatherServiceResponse[@"rain"][@"3h"] integerValue];
    
    // snow
    _snow3hours = [weatherServiceResponse[@"snow"][@"3h"] integerValue];
    
    // sys
    _country = weatherServiceResponse[@"sys"][@"country"];
    _sunrise = [NSDate dateWithTimeIntervalSince1970:[weatherServiceResponse[@"sys"][@"sunrise"] doubleValue]];
    _sunset = [NSDate dateWithTimeIntervalSince1970:[weatherServiceResponse[@"sys"][@"sunset"] doubleValue]];
    
    // weather
    _conditions = weatherServiceResponse[@"weather"];
    
    // wind
    _windDirection = [weatherServiceResponse[@"wind"][@"dir"] integerValue];
    _windSpeed = [weatherServiceResponse[@"wind"][@"speed"] doubleValue];
}

+ (double)kelvinToCelsius:(double)degreesKelvin
{
    const double ZERO_CELSIUS_IN_KELVIN = 273.15;
    return degreesKelvin - ZERO_CELSIUS_IN_KELVIN;
}

@end