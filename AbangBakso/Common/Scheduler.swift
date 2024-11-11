//
//  Scheduler.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 11/11/24.
//

import Foundation

final class Scheduler {

    static var background: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = QualityOfService.background
        return operationQueue
    }()

    static let mainScheduler = RunLoop.main
    static let mainThread = DispatchQueue.main
}
