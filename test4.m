% プログラムが開始したら画面にメッセージを出す
disp('線形移流方程式(陽解法)が始まった!!');

clear;

% 配列の準備．(3つの異なるdtで計算する)
x=zeros(11,1);
u_old=zeros(11,3); %古い時間ステップでの値
u_new=zeros(11,3); %新しい時間ステップでの値

% パラメーター設定
c=1;
N=10;       % 空間分割数
step_tot=5; % 時間ステップ総数
dx=1/N;

% x座標
for i=1:11
    x(i,1)=(i-1)*dx;
end

% 初期値
u_old(1,:)=1; % 境界条件
u_old(2:11,:)=0;

for j=1:3
    dt=dx/c/2*j; % dt=0.5*dx/c,dx/c,1.5*dx/cの3パターン
    for t=1:step_tot
        u_new(1,j)=1; % 境界条件
        for i=2:11
            % 差分方程式からu_newを計算
            u_new(i,j)=(1-c*dt/dx)*u_old(i,j)+c*dt/dx*u_old(i-1,j); 
        end
        if t==1
            clf('reset');
            fig=figure; % Figureを生成
            hold off;
            plot(x(:,1),u_old(:,j),'-','LineWidth',1.5); % 初期値をプロット
            hold on;
            plot(x(:,1),u_new(:,j),'-','LineWidth',1.5); % 直近の結果をプロット
        else
            plot(x(:,1),u_new(:,j),'-','LineWidth',1.5); % 直近の結果をプロット
        end
        u_old(:,j)=u_new(:,j);  % 次の時間ステップのためにu_oldを更新
    end
    legend('t=0','t=dt','t=2dt','t=3dt','t=4dt','t=5dt','Location','best');

    % FigureをJPEGで保存
    % 保存したいフォルダー
    dname='保存したいフォルダーのパス(C:\Users\tanaka\Documents\とか)';
    % 絶対パス込みのファイル名
    fname=append(dname,'result',sprintf('%i',j),'.jpg');
    % JPEGで保存
    print(fig,'-djpeg',fname,'-r600');
end

% プログラムが終了したら画面にメッセージと出す
disp('終わった!!');