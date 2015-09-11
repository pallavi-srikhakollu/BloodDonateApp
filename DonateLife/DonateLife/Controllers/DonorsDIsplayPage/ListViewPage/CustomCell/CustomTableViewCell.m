

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
- (IBAction)buttonActionContactNo:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_buttonForContact.titleLabel.text]];
    
}

@end
