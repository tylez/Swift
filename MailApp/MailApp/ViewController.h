//
//  ViewController.h
//  MailApp
//
//  Created by Alejandro Guerra Carbonell on 18/08/14.
//  Copyright (c) 2014 Alejandro Guerra Carbonell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *estado;

- (IBAction)sendMail:(id)sender;



@end
