コマンドライン引数をテキストボックスに出すだけのアプリを作った[0]。Fusion 360 がデフォルトブラウザを勝手に開いてそのURLが使い捨てなのでメインのブラウザに URL をコピペできなくてむしゃくしゃして調べたらStackOverflowで「バッチファイル作ればいける」って言われてるけどなぜか
動かなくて(たぶん Windows 側で保安上小細工されてる)、Vector[1] にもダイアログで出すやつはないし Bing Chat に聞いたら hallucination したので本格的にないなと思って適当にコピペで作った。

args[0] にはバイナリの名前が入ってて args[1] 以降は null の可能性があるのでただ join すると頭が入るし落ちてもいいんだけど 1 以降とかで指定して 1 がないと落ちるし for ループと条件判断を含まない形にしたくて最後の引数を出すようにした。2つ以上渡してきて最後がURLじゃなかったら知らん。

0: https://github.com/numpad0/show-arg-on-textbox-csharp  
1: https://www.vector.co.jp/soft/win95/util/se485437.html  
