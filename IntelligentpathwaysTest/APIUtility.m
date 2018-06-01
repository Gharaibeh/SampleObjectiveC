//
//  APIUtility.m
//  IntelligentpathwaysTest
//
//  Created by Hasan Gharaibeh on 1/6/18.
//  Copyright © 2018 Hasan Gharaibeh. All rights reserved.
//

#import "APIUtility.h"


@interface AppDelegate ()

@end


@implementation APIUtility
{
    
    NSDictionary *flickrDictionary;
    
    NSMutableArray *cFRAIPArray;
    
}
@end

 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *myurl = [NSURL URLWithString:@"https://api.nasa.gov/planetary/apod?date=2011-07-13&api_key=DEMO_KEY"];
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:myurl];
    NSURLConnection *myConnection = [NSURLConnection connectionWithRequest:myRequest delegate:self];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
    NSURL *myurl = [NSURL URLWithString:@"https://api.nasa.gov/planetary/apod?date=2011-07-13&api_key=DEMO_KEY"];
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:myurl];
    NSURLConnection *myConnection = [NSURLConnection connectionWithRequest:myRequest delegate:self];
    
    
    
    //https://api.nasa.gov/planetary/apod?date=2011-07-13&api_key=DEMO_KEY
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
    
    int errorCode = httpResponse.statusCode;
    
    NSString *fileMIMEType = [[httpResponse MIMEType] lowercaseString];
    
    NSLog(@"response is %d, %@", errorCode, fileMIMEType);
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    // NSLog(@"data is %@", data);
    
    NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"string is %@", myString);
    
    NSError *e = nil;
    
    NSDictionary *flickrDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
    
    NSLog(@"dictionary is %@", flickrDictionary);
    NSLog(@"vaue is ...  %@",[flickrDictionary valueForKey:@"title"]);
    
    [self loadImage:[flickrDictionary valueForKey:@"url"]];
    
}

-(void)loadImage:(NSString *)imgurl
{
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imgurl]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            self.img1.image = [UIImage imageWithData: data];
        });
        //[data release];
    });
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    
    
    // inform the user
    
    NSLog(@"Connection failed! Error - %@ %@",
          
          [error localizedDescription],
          
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    // do something with the data
    
    // receivedData is declared as a method instance elsewhere
    
    NSLog(@"Succeeded!");
    
    cFRAIPArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    for (NSString *key in flickrDictionary) {
        
        NSLog(@"the key is %@", flickrDictionary[key]);
        
        id object = flickrDictionary[key]; // this will be apikey,format,method etc...
        
        if ([object isKindOfClass:[NSDictionary class]]) { //first 4 are arrays-crsh-dicts
            
            NSLog(@"object valueForKey is %@", [object valueForKey:@"_content"]);
            
            [cFRAIPArray addObject:[object valueForKey:@"_content"]];
            
            
            
        } else {
            
            [cFRAIPArray addObject:flickrDictionary[key]];
            
        }
        
    }
    
    //cell.textLabel.text = [cFRAIPArray objectAtIndex:indexPath.row];
    
    
    NSLog(@"cfraiparray %@", cFRAIPArray);
    
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
