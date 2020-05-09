//
//  PlanViewController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/5/9.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit
import Alamofire

class PlanViewController: UIViewController {

    @IBOutlet var wapper: UIView!
    
    var header: UIView!
    
    var height: CGFloat = 0
    var topTitle: UILabel!
    var backButton: UIButton!
    var pdfView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        drawHeader()
        
        let headers: HTTPHeaders = [
            "Cookie": getSession()!
        ]
        
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        
        Alamofire.download(getPlanUrl, method: .get, headers: headers, to: destination).downloadProgress {
            progress in
            
            
        }.responseData {
            response in
        
            if (response.response?.statusCode == 200) {
                setPDFToCookie(url: response.destinationURL!)
                self.drawPDF(url: response.destinationURL!)
            }
        
            else {
                self.showMsgbox(_message: "网络出错，无法下载文件,连接不到服务器")
            }
        }
    }
    
    func drawHeader() {
        // 头部
        header = UIView(frame: CGRect(x: 0, y: 0, width: wapper.frame.width, height: 50))
        header.backgroundColor = Colors.blueBackground
        wapper.addSubview(header)
        // 返回按钮
        backButton = BackButton(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        backButton.setImage(Icons.left.iconFontImage(fontSize: 33, color: .white), for: .normal)
        backButton.setTitle("返回", for: .normal)
        backButton.titleLabel?.textColor = .white
        backButton.titleLabel?.textAlignment = .left
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        header.addSubview(backButton)
        
        // 标题
        topTitle = UILabel(frame: CGRect(x: 80, y: 5, width: mainSize.width-160, height: 40))
        topTitle.numberOfLines = 2
        topTitle.lineBreakMode = NSLineBreakMode.byCharWrapping
        topTitle.textAlignment = .center
        topTitle.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        topTitle.text = "2020年度科学基金资助计划\n（国科金发〔2020〕X号）"
        topTitle.textColor = UIColor(red: 158/255.0, green: 188/255.0, blue: 240/255.0, alpha: 1)
        header.addSubview(topTitle)
        
        height = header.frame.height
    }

    func drawPDF(url: URL) {
        pdfView = UIWebView(frame: CGRect(x: 0, y: height, width: wapper.frame.width, height: wapper.frame.height-height))
        wapper.addSubview(pdfView)
        
        pdfView.scalesPageToFit = true
        let request = URLRequest(url: url)
        pdfView.loadRequest(request)
    }
    
    @objc func back(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
