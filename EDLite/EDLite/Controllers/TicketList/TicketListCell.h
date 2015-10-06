//
//  TicketListCell.h
//  EDLite
//
//  Created by Nasirahmed on 29/09/15.
//  Copyright (c) 2015 Nasir. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TicketListCell;

@protocol TicketListCellDelegate <NSObject>

@optional
-(void)ticket:(TicketListCell*)ticketCell didTapTicketCellAtIndexPath:(NSIndexPath*)indexPath;

@end


@interface TicketListCell : UITableViewCell
@property (weak, nonatomic)IBOutlet UILabel* ticketIDLabel;
@property (weak, nonatomic)IBOutlet UILabel* ticketTitleLabel;
@property (weak, nonatomic)IBOutlet UILabel* ticketDescriptionLabel;
@property (weak, nonatomic)IBOutlet UILabel* ticketStatuslabel;
@property (weak, nonatomic)IBOutlet UIButton* ticketArchivedButton;
@property (weak, nonatomic) IBOutlet UIImageView* ticketAttachmentImageView;

@property (nonatomic) NSIndexPath* indexPath;
@property (weak, nonatomic) id <TicketListCellDelegate> delegate;
@end
