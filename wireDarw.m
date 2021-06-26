function wireDarw
oriPic=imread('shu.jpg');
nailNum=300;%钉子数量
randNum=80;%一次采样数量
brightAdd=30;
lineNum=3000;%线条数量



[rows,cols,nChannels]=size(oriPic);
if nChannels>1
    oriPic=rgb2gray(oriPic);
end

ratio=[1260,560]./[cols,rows];
fig=figure('units','pixels',...
        'position',[20 60 min(ratio)*(cols+1) min(ratio)*(rows+1)],...
        'Color',[1 1 1]);
ax=axes('Units','pixels',...
        'parent',fig,...  
        'Color',[1 1 1],...
        'Position',[0 0 min(ratio)*(cols+1) min(ratio)*(rows+1)],...
        'XLim',[0 cols+1],...
        'YLim',[0 rows+1],...
        'XColor','none',...
        'YColor','none');
hold on
ax.YDir='normal';



midX=(1+cols)/2;
midY=(1+rows)/2;
t=linspace(0,2*pi,nailNum+1);
t(end)=[];t=t(:);

nailPos=[(midX-0.5).*(cos(t)+1),(midY-0.5).*(sin(t)+1)]+0.5;
scatter(nailPos(:,1),nailPos(:,2),5,'filled','CData',[0 0 0])

degreeMat=oriPic(end:-1:1,:);
[XMesh,YMesh]=meshgrid((1:cols)-midX,(1:rows)-midY);
normXMesh=XMesh./(midX-0.5);
normYMesh=YMesh./(midY-0.5);
l2Mesh=normXMesh.^2+normYMesh.^2;
outCircleMesh=l2Mesh>1;
degreeMat=double(degreeMat);


[XSet,YSet]=meshgrid(1:cols,1:rows);

for i=1:lineNum
    randiNail=randi([1,nailNum],[randNum,2]);
    randiNail(randiNail(:,1)==randiNail(:,2),:)=[];
    lumSet=inf.*ones(1,size(randiNail,1));
    for j=1:size(randiNail,1)
        pnt1=nailPos(randiNail(j,1),:);
        pnt2=nailPos(randiNail(j,2),:);
        v=[pnt2(2)-pnt1(2),pnt1(1)-pnt2(1)];v=v./norm(v);
        onLine=abs((XSet-pnt1(1)).*v(1)+(YSet-pnt1(2)).*v(2))<1;
        onLine=onLine&(~outCircleMesh);
        if sum(sum(onLine))>10
            lumMean=mean(degreeMat(onLine));
            lumSet(j)=lumMean;
        else
            lumSet(j)=inf;
        end
    end
    [~,index]=sort(lumSet);
    S_pnt1=nailPos(randiNail(index(1),1),:);
    S_pnt2=nailPos(randiNail(index(1),2),:);
    S_v=[S_pnt2(2)-S_pnt1(2),S_pnt1(1)-S_pnt2(1)];S_v=S_v./norm(S_v);
    S_onLine=abs((XSet-S_pnt1(1)).*S_v(1)+(YSet-S_pnt1(2)).*S_v(2))<0.6;
    S_onLine=S_onLine&(~outCircleMesh);
    degreeMat(S_onLine)=degreeMat(S_onLine)+brightAdd;
    plot([S_pnt1(1),S_pnt2(1)],[S_pnt1(2),S_pnt2(2)],'Color',[0.2,0.2,0.2,0.4],'LineWidth',0.3)
    disp(i)
    pause(0.001)
end

end