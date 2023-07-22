require "csv" # CSVファイルを扱うためのライブラリを読み込んでいます

puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"

memo_type = gets.to_i # ユーザーの入力値を取得し、数字へ変換しています

# if文を使用して続きを作成していきましょう。
# 「memo_type」の値（1 or 2）によって処理を分岐させていきましょう。
if memo_type == 1
    puts "拡張子を除いたファイルを入力してください。"
    file_name = gets.chomp
    puts "メモしたい内容を記入してください。",
         "完了したらCtrl+Dを押します。"
    # ファイルへ書き込み
    memos = []
    while (memo = gets)
      memos << memo.chomp
    end
    CSV.open("#{file_name}.csv", "wb") do |csv|
      memos.each { |memo| csv << [memo] }
    end
elsif memo_type == 2
    puts "編集したいファイル名を拡張子を除いて入力してください。"
    file_name = gets.chomp
    if File.exist?("#{file_name}.csv") == false
        puts "指定されたファイルは存在しません。"
        return
    end
    puts "以下の入力で操作内容を決定してください。",
    "1 -> 新しく行を追加する。 / 2 -> 既存の行を編集する。"
    edit_type = gets.to_i
    if edit_type == 1
        puts "操作が完了したらCtrl+Dを押します。"
        memos = []
        while (memo = gets)
            memos << memo.chomp
        end
        CSV.open("#{file_name}.csv", "a") do |csv|
            memos.each { |memo| csv << [memo] }
        end
    elsif edit_type == 2
        puts "編集したい行番号を指定してください。"
        edit_index = gets.to_i
        # ユーザーが数字以外を入力した場合は中止
        if edit_index.zero?
            puts "無効な行番号です。"
            return
        end
        edit_index -= 1
        rows = CSV.read("#{file_name}.csv")
        # ユーザーが範囲外のインデックスを入力した場合は中止
        if edit_index > rows.length
            puts "無効な行番号です。"
            return
        end
        puts "指定された行の内容を表示します：#{rows[edit_index][0]}",
        "続けて入力を行い、編集が完了したらエンターキーを押してください。"
        edited_row_data = gets
        edited_row_data.chomp! unless edited_row_data.nil?
        rows[edit_index] = [edited_row_data]  
        # 編集したデータをCSVファイルに上書き保存
        CSV.open("#{file_name}.csv", 'wb') do |csv|
          rows.each do |row|
            csv << row
          end
        end
    else
        puts "1か2を半角で入力してください。"
    end
else
    puts "1か2を半角で入力してください。"
end
  


