//
//  EmoticonsHelper.swift
//  EmoticonsTest
//
//  Created by Menamobile on 17/4/13.
//  Copyright © 2017年 Mena. All rights reserved.
//

import UIKit


class EmoticonsHelper {
    
    /// 表情字符、图片对应表
    static let EmotionsTable = [
        "[):]": "ee_1.png",
        "[:D]": "ee_2.png",
        "[;)]": "ee_3.png",
        "[:p]": "ee_5.png",
        "[:-o]": "ee_4.png",
        "[(H)]": "ee_6.png",
        "[:@]": "ee_7.png",
        "[:s]": "ee_8.png",
        "[:$]": "ee_9.png",
        "[:(]": "ee_10.png",
        "[:'(]": "ee_11.png",
        "[:|]": "ee_12.png",
        "[(a)]": "ee_13.png",
        "[8o|]": "ee_14.png",
        "[8-|]": "ee_15.png",
        "[+o(]": "ee_16.png",
        "[<o)]": "ee_17.png",
        "[|-)]": "ee_18.png",
        "[*-)]": "ee_19.png",
        "[:-#]": "ee_20.png",
        "[:-*]": "ee_21.png",
        "[^o)]": "ee_22.png",
        "[8-)]": "ee_23.png",
        "[(|)]": "ee_24.png",
        "[(u)]": "ee_25.png",
        "[(S)]": "ee_26.png",
        "[(*)]": "ee_27.png",
        "[(#)]": "ee_28.png",
        "[(R)]": "ee_29.png",
        "[({)]": "ee_30.png",
        "[(})]": "ee_31.png",
        "[(k)]": "ee_32.png",
        "[(F)]": "ee_33.png",
        "[(W)]": "ee_34.png",
        "[(D)]": "ee_35.png",
        ]
    
    /// 正则表达式的格式
    static let pattern = "\\[.{2,3}\\]"
    
    /// bundle路径
    static let pathPrexfix = "ExpressionResource.bundle/"
    
    static func convertToCommonEmoticons(text: String, font: UIFont, textColor: UIColor) -> NSMutableAttributedString {
        
        /// 字体、颜色
        let textAttributes = [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: textColor]
        
        /// 获取字体的行高，作为表情的高度
        let attachmentHeight = font.lineHeight
        
        //转成NSString
        let originalNSString = text as NSString
        //通过str获得NSMutableAttributedString
        let attStr = NSMutableAttributedString.init(string: text, attributes: textAttributes)
        var regex: NSRegularExpression?
        do {
            regex = try NSRegularExpression.init(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        //获取到匹配正则的数据
        if let matches = regex?.matches(in: text, options: NSRegularExpression.MatchingOptions.withoutAnchoringBounds, range: NSMakeRange(0, attStr.string.count)) {
            if matches.count > 0 {
                //遍历符合的数据进行解析
                for i in 0..<matches.count {
                    let result = matches[matches.count-i-1]
                    let range = result.range
                    let emojiStr = originalNSString.substring(with: range)
                    //符合的数据是否为表情
                    if EmotionsTable.keys.contains(emojiStr) {
                        if let image = UIImage.init(named: pathPrexfix + EmotionsTable[emojiStr]!) {
                            //创建一个NSTextAttachment
                            let attachment = NSTextAttachment()
                            attachment.image  = image
                            
                            let attachmentWidth = attachmentHeight * image.size.width / image.size.height
                            attachment.bounds = CGRect(x: 0, y: (font.capHeight - font.lineHeight)/2, width: attachmentWidth, height: attachmentHeight)
                            //通过NSTextAttachment生成一个NSAttributedString
                            let rep = NSAttributedString(attachment: attachment)
                            //把表情于之前的字符串替换
                            attStr.replaceCharacters(in: range, with: rep)
                        }
                    }
                }
            }
        }
        
        return attStr
    }
    
}
