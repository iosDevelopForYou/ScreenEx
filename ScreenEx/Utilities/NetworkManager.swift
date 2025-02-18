//
//  NetworkManager.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 17.02.2025.
//

import Foundation
import Combine

class NetworkManager {
    
    
    static func downLoad(request: URLRequest) -> AnyPublisher<Data, any Error> {
        return URLSession.shared.dataTaskPublisher(for: request) // отправляет запрос в сеть и получает ответ
            .subscribe(on: DispatchQueue.global(qos: .utility)) // переводим дальнейшую работу в фоновый поток
            .tryMap { output -> Data in                        // проверяем валидный ли респонс и статус код в диапазоне от 200 до 300
                
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)                // переводим полученные данные на главный поток
            .eraseToAnyPublisher()                         // позволяет работать с любым типом паблишера(создает дженерик тип для паблишера)
    }
    
    static func handleCompletion(completion: Subscribers.Completion<any Error>) { // обрабатывает завершение ответа от сервера с успехом или с                                                                               ошибкой
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Ошибка - \(error.localizedDescription)")
        }
    }
}
