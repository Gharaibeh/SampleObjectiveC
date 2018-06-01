//
//  CountryDetails.h
//  IntelligentpathwaysTest
//
//  Created by Hasan Gharaibeh on 31/5/18.
//  Copyright © 2018 Hasan Gharaibeh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryDetails : UIViewController


@property   NSString *eventName;
@property   NSString *eventDate;
@property (weak, nonatomic) IBOutlet UILabel *EventTitle;
@property (weak, nonatomic) IBOutlet UIImageView *EventImage;
@property (weak, nonatomic) IBOutlet UITextView *EventDetails;




@end
