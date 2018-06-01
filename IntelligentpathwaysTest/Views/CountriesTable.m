//
//  CountriesTable.m
//  IntelligentpathwaysTest
//
//  Created by Hasan Gharaibeh on 31/5/18.
//  Copyright © 2018 Hasan Gharaibeh. All rights reserved.
//

#import "CountriesTable.h"
#import "CountryDetails.h"
@interface CountriesTable ()

@end

@implementation CountriesTable
{
    
    IBOutlet UITableView *myTable;
    NSMutableArray *NasaEventNames;
    NSMutableArray *NasaEventDates;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Array of NASA events names from 1/1/2010   - 12/1/2010
    NasaEventNames = [[NSMutableArray alloc]initWithObjects:
               @"Not a Blue Moon",
               @"Blue Moon Eclipse",
               @"A Force from Empty Space: The Casimir Effect",
               @"Comet Halley's Nucleus: An Orbiting Iceberg",
               @"A Roll Cloud Over Uruguay",
               @"The Spotty Surface of Betelgeuse",
               @"The Tail of the Small Magellanic Cloud",
               @"The Mystery of the Fading Star",
               @"Andromeda Island Universe",
               @"A Spherule from the Earth's Moon",
               @"The Astronaut Who Captured a Satellite",
               @"The Flame Nebula in Infrared", nil];
    
    //Array of NASA events dates from 1/1/2010   - 12/1/2010
    NasaEventDates = [[NSMutableArray alloc]initWithObjects:
                      @"2010-01-01",
                      @"2010-01-02",
                      @"2010-01-03",
                      @"2010-01-04",
                      @"2010-01-05",
                      @"2010-01-06",
                      @"2010-01-07",
                      @"2010-01-08",
                      @"2010-01-09",
                      @"2010-01-10",
                      @"2010-01-11",
                      @"2010-01-12", nil];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       return [NasaEventNames count] ;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellId];
    
    NSString *stringForCell;
   
        stringForCell= [NasaEventNames objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:stringForCell];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  //for debug.
    // NSLog(@"Section:%d Row:%d selected and its data is %@", indexPath.section,indexPath.row,cell.textLabel.text);
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self->myTable indexPathForSelectedRow];

    // send parameters through Segue
     CountryDetails  *destViewController = segue.destinationViewController;
 
    destViewController.eventName =  [NasaEventNames objectAtIndex:indexPath.row];
    destViewController.eventDate =  [NasaEventDates objectAtIndex:indexPath.row];

    
    
}
 
 

@end
