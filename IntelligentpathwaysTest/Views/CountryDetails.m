//
//  CountryDetails.m
//  IntelligentpathwaysTest
//
//  Created by Hasan Gharaibeh on 31/5/18.
//  Copyright © 2018 Hasan Gharaibeh. All rights reserved.
//

#import "CountryDetails.h"

@interface CountryDetails ()
{
     NSDictionary *eventDictionary;
     NSMutableArray *eventArray;
 }

@end

@implementation CountryDetails

 

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.EventTitle.text = self.eventName;
    self.EventDetails.text = self.eventDate;

    // API URL, for testing only it takes date and static key for demo
    NSString *api_url = @"https://api.nasa.gov/planetary/apod?";
    
    // API URL builder
    NSString *selectedDate = [@"date=" stringByAppendingString:self.eventDate];
    api_url = [api_url stringByAppendingString:selectedDate];
    api_url = [api_url stringByAppendingString:@"&"];
    api_url = [api_url stringByAppendingString:@"api_key=DEMO_KEY"];
    
    
    NSURL *myurl = [NSURL URLWithString:api_url];
 
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:myurl];
    NSURLConnection *myConnection = [NSURLConnection connectionWithRequest:myRequest delegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
    
    int errorCode = httpResponse.statusCode;
    
    NSString *fileMIMEType = [[httpResponse MIMEType] lowercaseString];
    
    //NSLog(@"response is %d, %@", errorCode, fileMIMEType);
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    // NSLog(@"data is %@", data);
    
    NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //NSLog(@"string is %@", myString);
    
    NSError *e = nil;
    
    NSDictionary *eventDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
    
    //NSLog(@"dictionary is %@", eventDictionary);
    //NSLog(@"vaue is ...  %@",[eventDictionary valueForKey:@"title"]);
    
    [self loadImage:[eventDictionary valueForKey:@"url"]];
    [self loadDiscription:[eventDictionary valueForKey:@"explanation"]];

}

-(void)loadImage:(NSString *)imgurl
{
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imgurl]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
             self.EventImage.image = [UIImage imageWithData: data];
        });
     });
}


-(void)loadDiscription:(NSString *)text
{
    self.EventDetails.text = text;
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    
    
    // inform the user
    
    //NSLog(@"Connection failed! Error - %@ %@",[error localizedDescription],[[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    // do something with the data
    
    // receivedData is declared as a method instance elsewhere
    
   // NSLog(@"Succeeded!");
    
    eventArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    for (NSString *key in eventDictionary) {
        
        //NSLog(@"the key is %@", eventDictionary[key]);
        
        id object = eventDictionary[key]; // this will be apikey,format,method etc...
        
        if ([object isKindOfClass:[NSDictionary class]]) { //first 4 are arrays-crsh-dicts
            
            //NSLog(@"object valueForKey is %@", [object valueForKey:@"_content"]);
            
            [eventArray addObject:[object valueForKey:@"_content"]];
            
            
            
        } else {
            
            [eventArray addObject:eventDictionary[key]];
            
        }
        
    }
    
    //cell.textLabel.text = [eventArray objectAtIndex:indexPath.row];
    
    
    //NSLog(@"eventArray %@", eventArray);
    
    //[self.tableView reloadData];
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
