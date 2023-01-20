//
//  NetworkManager.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 26.12.2022.
//
import Foundation

func createUser(user: User, completion: @escaping (Result<User, Error>) -> Void) {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    guard let data = try? encoder.encode(user) else {
        completion(.failure(NSError()))
        return
    }
    
    guard let url = URL(string: "http://localhost:3000/users/create") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = data
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            print(httpResponse.statusCode)
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
            }
        }
        guard let data = data else {
            completion(.failure(NSError()))
            return
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let user = try decoder.decode(User.self, from: data)
            print(user)
            completion(.success(user))
        } catch {
            completion(.failure(error))
        }
    }
    
    task.resume()
}


func getUser(id: String, completion: @escaping (Result<[User], Error>) -> Void) {
    
    guard let url = URL(string: "http://localhost:3000/users/user/\(id)") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data, let user = try? JSONDecoder().decode([User].self, from: data) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])
            completion(.failure(error))
            return
        }
        completion(.success(user))
    }
    task.resume()
    
}

func getTasks(id: String, completion: @escaping (Result<[TaskModel], Error>) -> Void) {
    
    guard let url = URL(string: "http://localhost:3000/tasks/\(id)") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data, let tasks = try? JSONDecoder().decode([TaskModel].self, from: data) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])
            completion(.failure(error))
            return
        }
        completion(.success(tasks))
    }
    task.resume()
    
}

func getFinishedTasks(id: String, completion: @escaping (Result<[TaskModel], Error>) -> Void) {
    
    guard let url = URL(string: "http://localhost:3000/tasks/\(id)/completed") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data, let tasks = try? JSONDecoder().decode([TaskModel].self, from: data) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])
            completion(.failure(error))
            return
        }
        completion(.success(tasks))
    }
    task.resume()
    
}

func getUnfinishedTasks(id: String, completion: @escaping (Result<[TaskModel], Error>) -> Void) {
    
    guard let url = URL(string: "http://localhost:3000/tasks/\(id)/uncompleted") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data, let tasks = try? JSONDecoder().decode([TaskModel].self, from: data) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])
            completion(.failure(error))
            return
        }
        completion(.success(tasks))
    }
    task.resume()
    
}

func createTask(task: TaskModel, completion: @escaping (Result<TaskModel, Error>) -> Void) {
    let url = URL(string: "http://localhost:3000/tasks/create/")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")

    let taskData = try! JSONEncoder().encode(task)
    request.httpBody = taskData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        if let httpResponse = response as? HTTPURLResponse {
            print(httpResponse.statusCode)
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
            }
        }
        guard let data = data else {
            completion(.failure(NSError()))
            return
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let user = try decoder.decode(TaskModel.self, from: data)
            print(user)
            completion(.success(user))
        } catch {
            completion(.failure(error))
        }
    }
    
    task.resume()
}

func updateTask(updatedTask: TaskModel, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    let url = URL(string: "http://localhost:3000/tasks/")!
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try! JSONSerialization.data(withJSONObject: updatedTask.toDictionary(), options: [])

    let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
    task.resume()
}

func updateUser(updatedUser: User, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    let url = URL(string: "http://localhost:3000/users/")!
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try! JSONSerialization.data(withJSONObject: updatedUser.toDictionary(), options: [])

    let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
    task.resume()
}

func deleteATask(taskId: String, completion: @escaping (Bool) -> Void) {
    let url = URL(string: "http://localhost:3000/tasks/delete/\(taskId)")!
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print(error)
            completion(false)
            return
        }

        if let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                // handle success
                completion(true)
            } else {
                // handle other status codes
                completion(false)
            }
        }
    }
    task.resume()
}
