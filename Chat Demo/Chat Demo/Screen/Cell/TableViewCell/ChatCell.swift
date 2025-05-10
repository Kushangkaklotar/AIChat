//
//  ChatCell.swift
//  Chat Demo
//
//  Created by Kushang  on 19/04/25.
//

import UIKit
import Down

class ChatCell: UITableViewCell {

    @IBOutlet weak var rightMessageView: UIView!
    @IBOutlet weak var leftMessageView: UIView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftTimeLabel: UILabel!
    @IBOutlet weak var rightTimeLabel: UILabel!
    @IBOutlet weak var leftMessageLabel: UILabel!
    @IBOutlet weak var rightMessageLabel: UILabel!
    @IBOutlet weak var leftMainView: UIView!
    @IBOutlet weak var rightMainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.manageUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.self.rightMessageLabel.text = ""
        self.self.leftMessageLabel.text = ""
    }
    
    func manageUI(){
        [self.rightMessageView, self.leftMessageView].forEach{$0?.layer.cornerRadius = 10}
        [self.rightMessageView, self.leftMessageView].forEach{$0?.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.8862745098, blue: 0.9019607843, alpha: 1)}
        [self.leftImageView, self.rightImageView].forEach{$0?.layer.cornerRadius = 15}
    }

    var chatDataSet: chatData? {
        didSet{
            if chatDataSet?.isMyMessage == false {
                self.leftMainView.isHidden = false
                self.leftMessageView.isHidden = false
                self.rightMainView.isHidden = true
                self.rightMessageView.isHidden = true
                do {
                    let down = Down(markdownString: chatDataSet?.message ?? "")
                    let attributedString = try down.toAttributedString()
                    self.leftMessageLabel.attributedText = attributedString
                } catch {
                    print("Markdown parsing failed: \(error)")
                }
                self.leftTimeLabel.text = Utility.convertTimestampToDateString(chatDataSet?.time ?? TimeInterval())
            } else {
                self.leftMessageView.isHidden = true
                self.leftMainView.isHidden = true
                self.rightMainView.isHidden = false
                self.rightMessageView.isHidden = false
                do {
                    let down = Down(markdownString: chatDataSet?.message ?? "")
                    let attributedString = try down.toAttributedString()
                    self.rightMessageLabel.attributedText = attributedString
                } catch {
                    print("Markdown parsing failed: \(error)")
                }
                self.rightTimeLabel.text = Utility.convertTimestampToDateString(chatDataSet?.time ?? TimeInterval())
            }
        }
    }
    
    // MARK: - IB Action -
    @IBAction func onRightCopy(_ sender: Any) {
        UIPasteboard.general.string = chatDataSet?.message ?? ""
    }
    @IBAction func onLeftCopy(_ sender: Any) {
        UIPasteboard.general.string = chatDataSet?.message ?? ""
    }
}
