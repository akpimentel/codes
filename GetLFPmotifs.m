 function [InfoMatrix]=GetLFPmotifs(a,b,c,d)
close all
Signal=a(b,:);
Time=a(c,:);
Fs=d;

hirange=(std(Signal)*5.5)*-1;%establece el valor de desviaciones estándar para el threshold
LfpSamples=find(Signal<hirange); %encuentra los puntos donde la señal es menor que el umbral
LfpSamplesTime=Time(LfpSamples); %indexa los valores encontrados al tiempo
TimeDiffLfpSamples=diff(LfpSamples); %obtiene la primera derivada de la señal que sobrepasa el umbral indexada al tiempo
TimeDiffLfpSamples=[NaN TimeDiffLfpSamples]; %agrega un NaN para equiparar el tamaño del vector
BegTrial=LfpSamplesTime(TimeDiffLfpSamples>150&TimeDiffLfpSamples<350);
BegTrial=[LfpSamples(1) BegTrial]; %reemplazas el NaN por el primer valor de la señal del LFP

Hd = designfilt('lowpassfir','FilterOrder',20,'CutoffFrequency',350, ...
       'DesignMethod','window','Window',{@kaiser,3},'SampleRate',Fs); 
filteredSignal = filter(Hd,Signal); %Aplicas un filto pasa bajas a 350 Hz
display(['Number of events detected = ' num2str(size(BegTrial,2))])

figure
plot(Time,Signal,Time,filteredSignal,'b')
set(gcf,'Color',[1,1,1],'position',[100 200 1200 300]);
hold on
xlim([0 120000])
plot(BegTrial,ones(size(BegTrial,1),1)*hirange,'r*','MarkerSize',5)

fh1=12499; %ventana 1 a considerar (en ms)
ThisMatrix=[];
close all
for ii=1:length(BegTrial)
    BegTrial=floor(BegTrial);
    this=Signal(BegTrial(ii):BegTrial(ii)+fh1);
    plot(this)
    ThisMatrix(ii,:)=[this'];
    close all
end
% numero de eventos (inspiraciones) en Y
% tiempo (500 ms) en X
WholeMatrix=[];
points_ms=625;
fHere=1:625:length(ThisMatrix);
tHere=625:625:length(ThisMatrix);
for aa=1:size(ThisMatrix,1)
    Data01=[];
    for ii=1:length(tHere)
        this=ThisMatrix(aa,fHere(ii):tHere(ii));
        Data01(:,ii)=this;
    end
    WholeMatrix=[WholeMatrix Data01];
end
SimilarityIndex(WholeMatrix);
InfoMatrix.LFPmotifs=WholeMatrix;
 end