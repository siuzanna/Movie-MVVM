//
//  NetworkService.swift
//  Movie
//
//  Created by siuzanna on 19/12/21.
//

import Foundation

class NetworkService {

    private let urlSession: URLSession

    required init(session: URLSession = URLSession.shared) {
        urlSession = session
    }

    func sendRequest<SuccessModel: Codable>(
        urlRequest: URLRequest,
        successModel: SuccessModel.Type,
        completion: @escaping (ProResult<SuccessModel>) -> Void
    ) {
        urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else {
                debugPrint("Your class is dead")
                return
            }
            if let error = self.validateErrors(data: data, response: response, error: error) {
                if case NetworkErrors.unauthorized = error {

                } else if case NetworkErrors.badRequest = error {
                    if let model = self.transformFromJSON(data: data, objectType: FailureModel.self) {
                        completion(.badRequest(model))
                    }
                } else {
                    completion(.failure("Check you JSON MODEL"))
                }
            } else if let model = self.transformFromJSON(data: data, objectType: successModel) {
                completion(.success(model))
            } else {
                completion(.failure("Some supernatural things happened!!!"))
            }
        }.resume()
    }

    private func validateErrors(data: Data?, response: URLResponse?, error: Error?) -> Error? {
        if let error = error {
            return error
        }
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            return URLError(.badServerResponse)
        }
        switch statusCode {
        case StatusCode.okey.rawValue:
            return nil
        case StatusCode.badRequest.rawValue:
            return NetworkErrors.badRequest
        default:
            break
        }
        return nil
    }

    private func transformFromJSON<Model: Codable>(
        data: Data?,
        objectType: Model.Type
    ) -> Model? {
        guard let data = data else {return nil}
        return try? JSONDecoder().decode(Model.self, from: data)
    }
}
