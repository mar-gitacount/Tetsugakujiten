//
//  ContentView.swift
//  Tetsugakujiten
//
//  Created by 市川マサル on 2022/10/12.
//

import SwiftUI
import FirebaseDatabase

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                Text("こんにちはソクラテス")
            
            }.frame(maxHeight:.infinity)
                     FooterBlock()
            testdb() 
            
                
        }.frame(maxHeight:.infinity)
    }
}




//メインブロックも構造体にする。全ページ共通構造体を呼び出して、ページごとに値を変える。
//メインブロックは呼び出すと、画面一杯のオブジェクトを設定する。
//値に関しては呼び出し元で設定したい。
struct MainBlock: View{
    @State var Stack: Bool = false
    @State var Image1: String = ""
    @State var Text1: String = ""
    var body: some View {
        VStack {
            HStack {
                //Image(systemName: self.Image1 = "test")
            }
        }
        Text("メイン")
    }
    //ここでFooterBlockを呼ぶのもあり。
}
//ここでfooterの構造体を作る。
struct FooterBlock: View{
    var body: some View {
        //Spacer()
        HStack(alignment: .lastTextBaseline) {
            
            VStack {
                Image(systemName: "house")
                Text("ホーム")
            }
            //Spacer()
            VStack {
                Image(systemName: "person")
                Text("アカウント")
            }
            
        }.frame(maxWidth:.infinity)
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct testdb: View {
    @State var message = ""
    var body: some View {
        VStack {
            Text(message)
                .padding()
        //onAppearはviewが表示された時に呼び出されるアクション
        //selfはそれ自体という意味。self変数=値とすれば、その変数の値が変わる。
        }.onAppear {
           // var ref: DatabaseReference!
            //データベースのインスタンス作成。
            let ref = Database.database().reference()
            //ref = Database.database().reference()
            //messageをダブルクｫーテーションで囲むとなぜかクラッシュする。
            //データベースにネストされた子ノードのmeesageデータを読み込む
            ref.child("message").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                    self.message = "test"
                }
                //notnillを抜けることによって、エラーを防ぐ。
                else if let snapshot = snapshot {
                    if snapshot.exists(){
                        guard let message = snapshot.value as? String else {
                            self.message = "test"
                            return
                        }
                        self.message = message
                    }
                }
                else {
                    self.message = "test"
                    print("No data available")
                }
            }
        }
    }
}
