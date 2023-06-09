% ←これを書いた後(緑字部分)は実行されない

% プログラムが開始したら画面に「始まった!!」と出す
disp('始まった!!');


%//////////////////////////////////////////////////////////
% 前世の記憶を削除(これまでの計算が影響しないように初期化)
%//////////////////////////////////////////////////////////
clear;

%//////////////////////////////////////////////////////////
% 配列(記憶してほしい値の入れ物)を用意する(用意しなくてもできる)
%//////////////////////////////////////////////////////////

N=100;   % 区間の分割数
dx=1/N;  % 区間の分割幅

% 101×1の配列(中身はすべて0)を定義している
x=zeros(101,1);  % xの配列
y=zeros(101,1);  % yの配列
% 配列の要素には１から順番に番号がついている


%//////////////////////////////////////////////////////////
% xとy(x=0)の値を配列に格納する
%//////////////////////////////////////////////////////////

% for文----------------------------------------------------
% i=1~N+1までforとendの間に書いた処理を繰り返す
%----------------------------------------------------------

% x
for i=1:N+1
    x(i)=(i-1)*dx; %さっき用意した配列xのi番目に(i-1)*dxが格納される
end

% y(x=0)
y(1)=1;


%//////////////////////////////////////////////////////////
% 差分法で微分方程式を解く
%//////////////////////////////////////////////////////////

for i=2:N+1
    y(i)=(1-dx)*y(i-1);
end


%//////////////////////////////////////////////////////////
% 結果をグラフにする
%//////////////////////////////////////////////////////////

% 差分法で計算した結果をプロット 
plot(x(:),y(:),'-','Color','r','LineWidth',1);

% plotコマンド-------------------------------------------------
% x(:)で配列xすべてをx軸に指定
% x(1:50)などとすれば一部だけ指定することも可能

% '-'で線の形を実線に指定，'Color','r'で色を赤に指定，
% 'LineWidth',1で線の太さを1に指定

% 他にもいろいろオプションがある
%--------------------------------------------------------------


% 解析解もプロットしてみる
for i=1:N+1
    z(i)=exp(-x(i)); 
    % z配列を先に宣言しなかったのでこの処理をするたびにzのサイズが変わる
end
hold on; % hold on で同じグラフにプロット
plot(x(:),z(:),'-.','Color','b','LineWidth',1);

legend('est','exa'); %凡例をplotした順につける


% x=1での計算誤差を画面に表示させてみる
error=y(101)-z(101);
disp('x=1での誤差は');
disp(error);


% プログラムが終了したら画面に「終わった!!」と出す
disp('終わった!!');