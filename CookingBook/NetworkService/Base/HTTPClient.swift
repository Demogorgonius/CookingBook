//
//  HTTPClient.swift
//  CookingBook
//
//  Created by sidzhe on 28.08.2023.
//

import Foundation

//MARK: - RecipeClient Protocol

protocol RecipeClient {
    func sendRequest<T: Decodable>(endpoint: RecipeEndpoint, responseModel: T.Type) async -> Result<T, RequestError>
    func sendSearchRequest<T: Decodable>(endpoint: RecipeEndpoint, responseModel: T.Type, type: String) async -> Result<T, RequestError>
    func sendRecentRequest<T: Decodable>(endpoint: RecipeEndpoint, responseModel: T.Type) async -> Result<T, RequestError>
    func sendIdRequest<T: Decodable>(id: String, endpoint: RecipeEndpoint, responseModel: T.Type) async -> Result<T, RequestError>
}


//MARK: - Extension RecipeClient

extension RecipeClient {
    func sendRequest<T: Decodable>(endpoint: RecipeEndpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.item
        
        guard let url = urlComponents.url else { return .failure(.invalidURL)}
   
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else { return .failure(.noResponse)}
            
            switch response.statusCode {
                
            case 200...299:
                
                guard let decode = try? JSONDecoder().decode(responseModel, from: data) else { return .failure(.decode)}
                return .success(decode)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
    
    func sendSearchRequest<T: Decodable>(endpoint: RecipeEndpoint, responseModel: T.Type, type: String) async -> Result<T, RequestError> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = [
            URLQueryItem(name: "apiKey", value: "76c720e3086144478cbcd27fb948b527"),
            URLQueryItem(name: "addRecipeInformation", value: "true"),
            URLQueryItem(name: "type", value: type)
            
        ]
        
        guard let url = urlComponents.url else { return .failure(.invalidURL)}
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else { return .failure(.noResponse)}
            
            switch response.statusCode {
                
            case 200...299:
                guard let decode = try? JSONDecoder().decode(responseModel, from: data) else { return .failure(.decode)}
                return .success(decode)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
    
    func sendRecentRequest<T: Decodable>(endpoint: RecipeEndpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.item
        
        guard let url = urlComponents.url else { return .failure(.invalidURL)}
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else { return .failure(.noResponse)}
            
            switch response.statusCode {
                
            case 200...299:
                guard let decode = try? JSONDecoder().decode(responseModel, from: data) else { return .failure(.decode)}
                return .success(decode)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
    
    func sendIdRequest<T: Decodable>(id: String, endpoint: RecipeEndpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = "/recipes/\(id)/information"
        urlComponents.queryItems = endpoint.item
        
        guard let url = urlComponents.url else { return .failure(.invalidURL)}
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else { return .failure(.noResponse)}
            
            switch response.statusCode {
                
            case 200...299:
                guard let decode = try? JSONDecoder().decode(responseModel, from: data) else { return .failure(.decode)}
                return .success(decode)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
