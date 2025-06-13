function dst = Cosinesim(F1,F2)
%Cosine Similarity is used to compare feature vectors of images
%If the two images F1 and F2 have similar features, their cosine similarity
%will be higher, helping us find the most relevant image to F1

%First Calculate the dot product of F1 and F2
dproduct= sum(F1 .* F2);

%Calculate the magnitudes (Length of vectors in the euclidean space) of F1 and F2
mag_F1= sqrt(sum(F1.^2));
mag_F2= sqrt(sum(F2.^2));

%Calculate the cosine similarity:
similarity= dproduct/(mag_F1 * mag_F2);

%Calculate the distance:
dst= 1-similarity;

return;