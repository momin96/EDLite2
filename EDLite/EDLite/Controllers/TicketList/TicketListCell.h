//
//  TicketListCell.h
//  EDLite
//
//  Created by Nasirahmed on 29/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketListCell : UITableViewCell
@property (weak, nonatomic)IBOutlet UILabel* ticketIDLabel;
@property (weak, nonatomic)IBOutlet UILabel* ticketTitleLabel;
@property (weak, nonatomic)IBOutlet UILabel* ticketDescriptionLabel;
@property (weak, nonatomic)IBOutlet UILabel* ticketStatuslabel;

@end
