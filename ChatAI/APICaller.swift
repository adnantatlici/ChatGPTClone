//
//  API Caller.swift
//  ChatAI
//
//  Created by Mustafa Adnan Tatlıcı on 15.01.2023.
//

import OpenAISwift
import Foundation


final class APICaller {
    static let shared = APICaller()

    @frozen enum Constants {
        static let key = "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"
    }
    
    private var client: OpenAISwift?
    
    
    private init() {}
    
    public func setup() {
        self.client = OpenAISwift(authToken: Constants.key)
    }
    
    public func getResponce(input: String,
                            completion: @escaping (Result<String,Error>) -> Void) {
        client?.sendCompletion(with: input, completionHandler: { result in
            switch result {
            case .success(let model):
                print(String(describing: model.choices))
                let output = model.choices.first?.text ?? ""
                completion(.success(output))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}
