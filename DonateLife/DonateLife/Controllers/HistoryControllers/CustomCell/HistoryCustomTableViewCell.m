
#import "HistoryCustomTableViewCell.h"

@implementation HistoryCustomTableViewCell

- (void)awakeFromNib {
    
    // Initialization code
    //_imageViewForCetificate.layer.cornerRadius =
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
- (IBAction)deleteButtonAction:(id)sender {
    [self databaseSetter];
    NSLog(@"%ld",self.tag);
    NSPredicate *predicate =[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ = '%@'",IDNO,[NSString stringWithFormat: @"%ld", (long)self.tag]]];
    [_databaseHelper deleteWithPredicate:predicate];
    
}
#pragma mark: Database

-(void)databaseSetter{
    
    _databaseHelper = [[DBHelper alloc]init];
    _databaseHelper.dbName = @"HistoryInfo";
    NSLog(@"%@",_databaseHelper.dbName);
    _databaseHelper.context =[self managedObjectContext];
    
    
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
