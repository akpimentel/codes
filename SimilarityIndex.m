function [SimilarityMatrix]=SimilarityIndex(Data)

% Utilizar la fórmula de similitud de cosenos que es el resultado del
% ángulo entre 2 vectores n-dimensionales en un espacio n-dimensional. 
% Esto es el producto punto de dos vectores dividido por la longitud (o
% magnitud) de los dos vectores

ThisMatrix=[];
for ii=1:size(Data,2)
    for aa=1:size(Data,2)
        this=(sum(Data(:,ii).*Data(:,aa)))/(sqrt(sum(Data(:,ii).^2))*sqrt(sum(Data(:,aa).^2)));
        ThisMatrix(aa,ii)=this;
    end 
end
set(gcf,'Color',[1,1,1],'position',[759.0000 114.3333 510.6667 410.6667]);
imagesc(ThisMatrix)
set(gca, 'YDir','normal') 
colormap(jet)
title('Similarity Index')
xlabel('vector i (t)')
ylabel('vector i (t)')
colorbar

SimilarityMatrix.ThisMatrix=ThisMatrix;
AdrresTosave=[pwd '/SimilarityMatrix.mat'];
save(AdrresTosave,'SimilarityMatrix');
end
