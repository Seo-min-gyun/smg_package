//
//  NetworkCheck.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import Foundation
import Network
import UIKit

final class NetworkCheck {
    static let shared = NetworkCheck()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    let AlertView: UIAlertController = UIAlertController(title: "네트워크에 접속할 수 없습니다.", message: "네트워크 연결 상태를 확인해 주세요", preferredStyle: .alert)
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
    
    func showAlertOnRoot() {
        DispatchQueue.main.async {
            if let vc = UIApplication.shared.keyWindow?.visibleViewController {
                let alertController = self.AlertView
                
                let endAction = UIAlertAction(title: "종료", style: .destructive) {_ in
                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        exit(0)
                    }
                }
                
                let confirmAction = UIAlertAction(title: "설정", style: .default) {_ in
                    guard let url = URL(string: UIApplication.openSettingsURLString) else {return}
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }
                
                endAction.setValue(UIColor(rgb: Common.globalTextColor), forKey: "titleTextColor")
                confirmAction.setValue(UIColor(rgb: Common.globalTextColor), forKey: "titleTextColor")
                
                alertController.addAction(endAction)
                alertController.addAction(confirmAction)
                
                vc.present(alertController, animated: true)
            }
        }
    }
    
    public func startNetworkMonitoring() {
        print("NetworkMonitoring Started...")
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { [weak self] path in
            print("path ::: \(path)")
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
            
            if self?.isConnected == true {
                print("Network Connected!")
                DispatchQueue.main.async {
                    self?.AlertView.dismiss(animated: true)
                }
            } else {
                print("Network Disconnected")
                self?.showAlertOnRoot()
            }
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
}
