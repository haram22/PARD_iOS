//
//  ScheduleController.swift
//  PARD
//
//  Created by 김하람 on 7/3/24.
//

import UIKit

func getSchedule(for viewController: CalendarViewController) {
    if let urlLink = URL(string: url + "/schedule") {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlLink) { data, response, error in
            if let error = error {
                print("🚨 Error:", error)
                return
            }
            if let JSONdata = data {
                // 응답 데이터를 문자열로 변환하여 출력
                if let dataString = String(data: JSONdata, encoding: .utf8) {
                    print("✅ Get Schedule Response Data String: \(dataString)")
                }
                
                let decoder = JSONDecoder()
                do {
                    var schedules = try decoder.decode([ScheduleModel].self, from: JSONdata)
                    print("✅ Success: \(schedules)")
                
                    // "파트"라는 문자가 포함된 경우 제거
                    for index in schedules.indices {
                        schedules[index].part = schedules[index].part.replacingOccurrences(of: "파트", with: "")
                    }
                    
                    // userEffect에 있는 파트와 일치하거나 "전체"인 일정만 필터링
                    let userEffects = UserDefaults.standard.string(forKey: "userPart") ?? "iOS"
                    let filteredSchedules = schedules.filter { userEffects.contains($0.part) || $0.part == "전체" }

                    DispatchQueue.main.async {
                        viewController.schedules = filteredSchedules
                        viewController.updateEvents()
                    }
                } catch {
                    print("🚨 Decoding Error:", error)
                }
            }



        }
        task.resume()
    }
}


class ScheduleDataList {
    static let shared = ScheduleDataList()
    var error: Error? = nil
    var scheduleDataList: [ScheduleModel] = []
    
    func getSchedule(completion: @escaping (Result<[ScheduleModel], ScheduleFetchError>) -> Void) {
        guard let urlLink = URL(string: url + "/schedule") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlLink) { data, response, error in
            if let error = error {
                print("🚨 Error:", error)
                completion(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            if let dataString = String(data: data, encoding: .utf8) {
                print("✅ Get Schedule Response Data String: \(dataString)")
            }
            
            let decoder = JSONDecoder()
            do {
                let schedules = try decoder.decode([ScheduleModel].self, from: data)
                print("✅ Success: \(schedules)")
                completion(.success(schedules))
            } catch let decodingError {
                print("🚨 Decoding Error:", decodingError)
                completion(.failure(.decodingError(decodingError)))
            }
        }
        
        task.resume()
    }
}

enum ScheduleFetchError: Error {
    case invalidURL
    case requestFailed
    case noData
    case decodingError(Error)
}
