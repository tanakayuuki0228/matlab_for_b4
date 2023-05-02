% プログラムが開始したら画面にメッセージを出す
% （プログラム要所でメッセージを出せばバグがあったときに分かりやすい）
disp('2階常微分方程式(その2)が始まった!!');

clear;

% 配列はforループの前に宣言．ループ内で毎回サイズが変わると計算時間が増える．
x=zeros(41,3);
y=zeros(41,3);

for j=1:3
    N=5*2^(j-1); % 分割数を5,10,20と変えてみる
    dx=pi/2/N;  % 区間の分割幅
    
    A=zeros(N-1,N-1); % 係数行列を宣言
    b=zeros(N-1,1);   % 右辺ベクトルを宣言
       
    % xとy(x=0),y(x=1)の値を配列に格納する
    for i=1:N+1
        x(i,j)=(i-1)*dx;
    end
    y(1,j)=1;
    y(N+1,j)=1;

    % 係数行列，右辺ベクトルの値を格納する
    A(1,1)=2-dx^2; A(1,2)=-1; b(1)=y(1,j);
    for i=2:N-2
        A(i,i-1)=-1; A(i,i)=2-dx^2; A(i,i+1)=-1;
    end
    A(N-1,N-2)=-1; A(N-1,N-1)=2-dx^2; b(N-1)=y(N+1,j);

    % Matlabに連立方程式を解かせる(部分ピボットを使ったLU分解で解いている)
    y(2:N,j)=linsolve(A,b);
    % LU分解についてはこちらを参照
    % 部分ピボットを使ったLU分解についてはこちらを参照

    % 計算結果をプロット
    if j==1
        clf('reset'); %figureをリセット
        plot(x(1:N+1,j),y(1:N+1,j),'-','Color','r','LineWidth',1.5);
        hold on;
    elseif j==2
        plot(x(1:N+1,j),y(1:N+1,j),'-','Color','g','LineWidth',1.5);
    else
        plot(x(1:N+1,j),y(1:N+1,j),'-','Color','b','LineWidth',1.5);
    end

end

% 解析解も
x_exa=zeros(101,1);
y_exa=zeros(101,1);
for i=1:101
    x_exa(i)=(i-1)*pi/2/100;
    y_exa(i)=sin(x_exa(i))+cos(x_exa(i));
end
plot(x_exa(:),y_exa(:),'-.','Color','k','LineWidth',1.5);

% % グラフの表示設定
legend('N=5','N=10','N=20','exa','Location','best');
xlim([0 pi/2]); % x軸の表示範囲
ylim([1 1.45]); % y軸の表示範囲
xticks([0 pi/8 pi/4 pi*3/8 pi/2]); % x軸の目盛
xticklabels({'0','\pi/8','\pi/4','3\pi/8','\pi/2'}); % x軸の目盛

% プログラムが終了したら画面にメッセージと出す
disp('終わった!!');