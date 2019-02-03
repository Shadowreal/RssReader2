//
//  MyTableViewController.swift
//  RssReader
//
//  Created by Andrew Borisov on 2/3/19.
//  Copyright © 2019 Andrew Borisov. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController, XMLParserDelegate {

    var posts: [Post] = []
    var parser = XMLParser()
    
    
    var postElement: Post? = nil
    var tempElemen: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parser = XMLParser(contentsOf: URL(string: "https://news.tut.by/rss/index.rss")!)!
        parser.delegate = self
        parser.parse()

      
    }

   
    // MARK: - parser function
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Parser error - \(parseError)")
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        tempElemen = elementName
        if tempElemen == "item" {
            postElement = Post(title: "", link: "", date: "")
        }
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            if let post = postElement {
                posts.append(post)
            }
            postElement = nil
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if let post = postElement {
            
            if tempElemen == "title" {
                postElement?.title = post.title! + string
            }
            
            if tempElemen == "link" {
                postElement?.link = post.link! + string
            }
          
            if tempElemen == "date" {
                postElement?.date = post.date! + string
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return posts.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = posts[indexPath.row].title
        cell.detailTextLabel?.text = posts[indexPath.row].link
    
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
