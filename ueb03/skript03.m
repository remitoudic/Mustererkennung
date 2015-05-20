% Uebung 03
% ----------
% Video zu PCA: https://www.youtube.com/watch?v=7OAs0h0kYmk
%
% J. Cavojska, N. Lehmann

% Trainingsdaten, Testdaten und Clusterdaten laden
A = load('pendigits-training.txt');
B = load('pendigits-testing.txt');
C = load('clusters.txt');

% Daten aufbereiten
A_n   = size(A,2);
A_m   = size(A,1);
A = sortrows(A,A_n);
A_0 = A((A(:,17)==0),:);
A_1 = A((A(:,17)==1),:);
A_2 = A((A(:,17)==2),:);
A_3 = A((A(:,17)==3),:);
A_4 = A((A(:,17)==4),:);
A_5 = A((A(:,17)==5),:);
A_6 = A((A(:,17)==6),:);
A_7 = A((A(:,17)==7),:);
A_8 = A((A(:,17)==8),:);
A_9 = A((A(:,17)==9),:);
X = A(:,1:A_n -1); % alle Daten ausser der Zuglinie
x = min(X):max(X);
B_n   = size(B,2);
B_m   = size(B,1);

% Aufgabe 1 (3 Punkte)

% A 1.1: multivariate (mehrdimensionale) Normalverteilung
%        (Erwartungswert, Kovarianzmatrix) berechnen

% Erwartungswert fuer jede Koordinate fuer jeden Zug (0 bis 9)
E_A_0 = mean(A_0(:,1:A_n -1));
E_A_1 = mean(A_1(:,1:A_n -1));
E_A_2 = mean(A_2(:,1:A_n -1));
E_A_3 = mean(A_3(:,1:A_n -1));
E_A_4 = mean(A_4(:,1:A_n -1));
E_A_5 = mean(A_5(:,1:A_n -1));
E_A_6 = mean(A_6(:,1:A_n -1));
E_A_7 = mean(A_7(:,1:A_n -1));
E_A_8 = mean(A_8(:,1:A_n -1));
E_A_9 = mean(A_9(:,1:A_n -1));

% Kovarianzmatrix fuer jeden Zug (0 bis 9)
CVM_A_0 = cov(A_0(:,1:A_n -1));
CVM_A_1 = cov(A_1(:,1:A_n -1));
CVM_A_2 = cov(A_2(:,1:A_n -1));
CVM_A_3 = cov(A_3(:,1:A_n -1));
CVM_A_4 = cov(A_4(:,1:A_n -1));
CVM_A_5 = cov(A_5(:,1:A_n -1));
CVM_A_6 = cov(A_6(:,1:A_n -1));
CVM_A_7 = cov(A_7(:,1:A_n -1));
CVM_A_8 = cov(A_8(:,1:A_n -1));
CVM_A_9 = cov(A_9(:,1:A_n -1));

% Multivariante PDF generieren fuer jeden Zug (0 bis 9)
% wir geben hier kein Intervall an, weil die pdf hochdimensional ist 
% und nicht nur fuer einen bestimmten Bereich berechnet werden soll
A_0_mvpdf = mvnpdf(A_0(:,1:A_n -1), E_A_0, CVM_A_0);
A_1_mvpdf = mvnpdf(A_1(:,1:A_n -1), E_A_1, CVM_A_1);
A_2_mvpdf = mvnpdf(A_2(:,1:A_n -1), E_A_2, CVM_A_2);
A_3_mvpdf = mvnpdf(A_3(:,1:A_n -1), E_A_3, CVM_A_3);
A_4_mvpdf = mvnpdf(A_4(:,1:A_n -1), E_A_4, CVM_A_4);
A_5_mvpdf = mvnpdf(A_5(:,1:A_n -1), E_A_5, CVM_A_5);
A_6_mvpdf = mvnpdf(A_6(:,1:A_n -1), E_A_6, CVM_A_6);
A_7_mvpdf = mvnpdf(A_7(:,1:A_n -1), E_A_7, CVM_A_7);
A_8_mvpdf = mvnpdf(A_8(:,1:A_n -1), E_A_8, CVM_A_8);
A_9_mvpdf = mvnpdf(A_9(:,1:A_n -1), E_A_9, CVM_A_9);


% A 1.2: Testdaten anhand der A-Posteriori-PDF klassifizieren,
%        Konfusionsmatrix und Klassifikationsguete angeben
%        (Annahme: Gleichverteilte A-Priori-Wahrscheinlichkeit
%                  fuer jede Ziffer)

% A-Priori-Wahrscheinlichkeit fuer jeden Zug (0 bis 9)
A_x_apriori = 1 / length(unique(A(:,A_n)));

% A-Posteriori-Wahrscheinlichkeit fuer jeden Zug (0 bis 9)
% P(Zuglinie | Position) = P(Position | Zuglinie) * P(Zuglinie)
A_0_aposteriori = A_0_mvpdf * A_x_apriori;
A_1_aposteriori = A_1_mvpdf * A_x_apriori;
A_2_aposteriori = A_2_mvpdf * A_x_apriori;
A_3_aposteriori = A_3_mvpdf * A_x_apriori;
A_4_aposteriori = A_4_mvpdf * A_x_apriori;
A_5_aposteriori = A_5_mvpdf * A_x_apriori;
A_6_aposteriori = A_6_mvpdf * A_x_apriori;
A_7_aposteriori = A_7_mvpdf * A_x_apriori;
A_8_aposteriori = A_8_mvpdf * A_x_apriori;
A_9_aposteriori = A_9_mvpdf * A_x_apriori;

% Wir klassifizieren mit der L2-Norm.
M_classify = [];
for index = 1:size(B,1)
    trainData = B(index,1:B_n -1);
    A_0_aposteriori_predict = mvnpdf(trainData, E_A_0, CVM_A_0);
    A_1_aposteriori_predict = mvnpdf(trainData, E_A_1, CVM_A_1);
    A_2_aposteriori_predict = mvnpdf(trainData, E_A_2, CVM_A_2);
    A_3_aposteriori_predict = mvnpdf(trainData, E_A_3, CVM_A_3);
    A_4_aposteriori_predict = mvnpdf(trainData, E_A_4, CVM_A_4);
    A_5_aposteriori_predict = mvnpdf(trainData, E_A_5, CVM_A_5);
    A_6_aposteriori_predict = mvnpdf(trainData, E_A_6, CVM_A_6);
    A_7_aposteriori_predict = mvnpdf(trainData, E_A_7, CVM_A_7);
    A_8_aposteriori_predict = mvnpdf(trainData, E_A_8, CVM_A_8);
    A_9_aposteriori_predict = mvnpdf(trainData, E_A_9, CVM_A_9);
    
    [maxValue, indexAtMaxValue] = max([norm(A_0_aposteriori_predict),norm(A_1_aposteriori_predict),norm(A_2_aposteriori_predict),norm(A_3_aposteriori_predict),norm(A_4_aposteriori_predict),norm(A_5_aposteriori_predict),norm(A_6_aposteriori_predict),norm(A_7_aposteriori_predict),norm(A_8_aposteriori_predict),norm(A_9_aposteriori_predict)]);
    
    if (maxValue == norm(A_0_aposteriori_predict))     % train 0 predicted
        tmpVector = [B(index,1:B_n -1),B(index,B_n),0];
        M_classify = vertcat(M_classify,tmpVector);
    elseif (maxValue == norm(A_1_aposteriori_predict)) % train 1 predicted
        tmpVector = [B(index,1:B_n -1),B(index,B_n),1];
        M_classify = vertcat(M_classify,tmpVector);
    elseif (maxValue == norm(A_2_aposteriori_predict)) % train 2 predicted
        tmpVector = [B(index,1:B_n -1),B(index,B_n),2];
        M_classify = vertcat(M_classify,tmpVector);
    elseif (maxValue == norm(A_3_aposteriori_predict)) % train 3 predicted
        tmpVector = [B(index,1:B_n -1),B(index,B_n),3];
        M_classify = vertcat(M_classify,tmpVector);
    elseif (maxValue == norm(A_4_aposteriori_predict)) % train 4 predicted
        tmpVector = [B(index,1:B_n -1),B(index,B_n),4];
        M_classify = vertcat(M_classify,tmpVector);
    elseif (maxValue == norm(A_5_aposteriori_predict)) % train 5 predicted
        tmpVector = [B(index,1:B_n -1),B(index,B_n),5];
        M_classify = vertcat(M_classify,tmpVector);
    elseif (maxValue == norm(A_6_aposteriori_predict)) % train 6 predicted
        tmpVector = [B(index,1:B_n -1),B(index,B_n),6];
        M_classify = vertcat(M_classify,tmpVector);
    elseif (maxValue == norm(A_7_aposteriori_predict)) % train 7 predicted
        tmpVector = [B(index,1:B_n -1),B(index,B_n),7];
        M_classify = vertcat(M_classify,tmpVector);
    elseif (maxValue == norm(A_8_aposteriori_predict)) % train 8 predicted
        tmpVector = [B(index,1:B_n -1),B(index,B_n),8];
        M_classify = vertcat(M_classify,tmpVector);
    else                                       % train 9 predicted
        tmpVector = [B(index,1:B_n -1),B(index,B_n),9];
        M_classify = vertcat(M_classify,tmpVector);
    end % end-if
end % end-for_each

% Konfusionsmatrix
knownClass = M_classify(:, B_n);
predictedClass = M_classify(:, B_n +1);
confusionmat(knownClass, predictedClass)

%   341     0     0     0     0     0     0     0    22     0
%     0   350    12     0     1     0     0     0     1     0
%     0     8   355     0     0     0     0     1     0     0
%     0     9     0   320     0     1     0     1     0     5
%     0     0     0     0   362     0     0     0     0     2
%     0     0     0     1     0   323     0     0     2     9
%     0     0     0     0     0     0   325     0    11     0
%     0    28     0     0     0     0     0   314     5    17
%     0     0     0     0     0     0     0     0   336     0
%     0     5     0     0     0     0     0     1     1   329

% Klassifikationsguete
M_m = size(M_classify, 1);
corret_predicted = 0;
for index = 1:M_m
    if M_classify(index, B_n) == M_classify(index, B_n +1)
        corret_predicted = corret_predicted + 1;
    end
end
classification_quality = corret_predicted / M_m

%   0.9591

%%%%%%%%%%%%%%%%%%%%%%%%%%  Aufgabe 2 (4 Punkte)  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A 2.1: Erste Hauptkomponente der Trainingsdaten angeben

% Schritt 1: Subtraktion der Mittelwerte 
M_alt =A(:,1:A_n -1);
mu=mean(M_alt')';
M_neu = repmat(mu,1,size(M_alt,2));
M_minus_mean = M_alt - M_neu;

% Schritt 2: Berechnung der Kovarianzmatrix
CVM_A = cov(A(:,1:A_n -1));

% Schritt 3: Eigenwerte und Eigenvektoren der Kovarianzmatrix
e = eig(CVM_A); % gibt einen Spaltenvektor mit den Eigenwerten von CVM_A zur�ck
[VB,DB] = eig(CVM_A); % V = Eigenwerte von CVM_A % D = Diagonalmatrix der Eigenwerte zu CVM_A
erste_hauptkomponente = DB(:,1); % ist das die erste Huptkomponente?

% geht vielleicht auch cooler???
%M_pca = princomp(zscore(B(:,1:B_n -1))); % pca with standardized variables
%M_pca_fst = M_pca(:,1) % ?

% A 2.2: Dimensionsreduzierung mittels PCA,
%        Testdaten klassifizieren mit Bayes Klassifikator
%        (wie in Aufgabe 1)
%        Klassifikationsguete fuer alle Dimensionen angeben
pca_c1  = DB(:,1);  % Hauptkomponente 1
pca_c2  = DB(:,2);  % Hauptkomponente 2
pca_c3  = DB(:,3);  % Hauptkomponente 3
pca_c4  = DB(:,4);  % Hauptkomponente 4
pca_c5  = DB(:,5);  % Hauptkomponente 5
pca_c6  = DB(:,6);  % Hauptkomponente 6
pca_c7  = DB(:,7);  % Hauptkomponente 7
pca_c8  = DB(:,8);  % Hauptkomponente 8
pca_c9  = DB(:,9);  % Hauptkomponente 9
pca_c10 = DB(:,10); % Hauptkomponente 10
pca_c11 = DB(:,11); % Hauptkomponente 11
pca_c12 = DB(:,12); % Hauptkomponente 12
pca_c13 = DB(:,13); % Hauptkomponente 13
pca_c14 = DB(:,14); % Hauptkomponente 14
pca_c15 = DB(:,15); % Hauptkomponente 15
pca_c16 = DB(:,16); % Hauptkomponente 16
% wahrscheinlch ist hier ne umgebende FOR-Schleife besser...

A_princomp1  = CVM_A * pca_c1;  % Spaltenvektor: Reduzierung auf eine Dimmension
A_princomp2  = CVM_A * pca_c2;  % Spaltenvektor: Reduzierung auf eine Dimmension
A_princomp3  = CVM_A * pca_c3;  % Spaltenvektor: Reduzierung auf eine Dimmension
A_princomp4  = CVM_A * pca_c4;  % Spaltenvektor: Reduzierung auf eine Dimmension
A_princomp5  = CVM_A * pca_c5;  % Spaltenvektor: Reduzierung auf eine Dimmension
A_princomp6  = CVM_A * pca_c6;  % Spaltenvektor: Reduzierung auf eine Dimmension
A_princomp7  = CVM_A * pca_c7;  % Spaltenvektor: Reduzierung auf eine Dimmension
A_princomp8  = CVM_A * pca_c8;  % Spaltenvektor: Reduzierung auf eine Dimmension
A_princomp9  = CVM_A * pca_c9;  % Spaltenvektor: Reduzierung auf eine Dimmension
A_princomp10 = CVM_A * pca_c10; % Spaltenvektor: Reduzierung auf eine Dimmension
A_princomp11 = CVM_A * pca_c11; % Spaltenvektor: Reduzierung auf eine Dimmension
A_princomp12 = CVM_A * pca_c12; % Spaltenvektor: Reduzierung auf eine Dimmension
A_princomp13 = CVM_A * pca_c13; % Spaltenvektor: Reduzierung auf eine Dimmension
A_princomp14 = CVM_A * pca_c14; % Spaltenvektor: Reduzierung auf eine Dimmension
A_princomp15 = CVM_A * pca_c15; % Spaltenvektor: Reduzierung auf eine Dimmension
A_princomp16 = CVM_A * pca_c16; % Spaltenvektor: Reduzierung auf eine Dimmension

A_pc1_mean  = mean(A_princomp1);  % Erwartungswert der Hauptkomponente
A_pc2_mean  = mean(A_princomp2);  % Erwartungswert der Hauptkomponente
A_pc3_mean  = mean(A_princomp3);  % Erwartungswert der Hauptkomponente
A_pc4_mean  = mean(A_princomp4);  % Erwartungswert der Hauptkomponente
A_pc5_mean  = mean(A_princomp5);  % Erwartungswert der Hauptkomponente
A_pc6_mean  = mean(A_princomp6);  % Erwartungswert der Hauptkomponente
A_pc7_mean  = mean(A_princomp7);  % Erwartungswert der Hauptkomponente
A_pc8_mean  = mean(A_princomp8);  % Erwartungswert der Hauptkomponente
A_pc9_mean  = mean(A_princomp9);  % Erwartungswert der Hauptkomponente
A_pc10_mean = mean(A_princomp10); % Erwartungswert der Hauptkomponente
A_pc11_mean = mean(A_princomp11); % Erwartungswert der Hauptkomponente
A_pc12_mean = mean(A_princomp12); % Erwartungswert der Hauptkomponente
A_pc13_mean = mean(A_princomp13); % Erwartungswert der Hauptkomponente
A_pc14_mean = mean(A_princomp14); % Erwartungswert der Hauptkomponente
A_pc15_mean = mean(A_princomp15); % Erwartungswert der Hauptkomponente
A_pc16_mean = mean(A_princomp16); % Erwartungswert der Hauptkomponente

A_pc1_std = std(A_princomp1);    % Standardabweichgung der Hauptkomponente
A_pc2_std = std(A_princomp2);    % Standardabweichgung der Hauptkomponente
A_pc3_std = std(A_princomp3);    % Standardabweichgung der Hauptkomponente
A_pc4_std = std(A_princomp4);    % Standardabweichgung der Hauptkomponente
A_pc5_std = std(A_princomp5);    % Standardabweichgung der Hauptkomponente
A_pc6_std = std(A_princomp6);    % Standardabweichgung der Hauptkomponente
A_pc7_std = std(A_princomp7);    % Standardabweichgung der Hauptkomponente
A_pc8_std = std(A_princomp8);    % Standardabweichgung der Hauptkomponente
A_pc9_std = std(A_princomp9);    % Standardabweichgung der Hauptkomponente
A_pc10_std = std(A_princomp10);  % Standardabweichgung der Hauptkomponente
A_pc11_std = std(A_princomp11);  % Standardabweichgung der Hauptkomponente
A_pc12_std = std(A_princomp12);  % Standardabweichgung der Hauptkomponente
A_pc13_std = std(A_princomp13);  % Standardabweichgung der Hauptkomponente
A_pc14_std = std(A_princomp14);  % Standardabweichgung der Hauptkomponente
A_pc15_std = std(A_princomp15);  % Standardabweichgung der Hauptkomponente
A_pc16_std = std(A_princomp16);  % Standardabweichgung der Hauptkomponente

x = min(A_princomp1):max(A_princomp1); % richtiges Intervall ?
A_pc1_pdf = pdf('Normal',x,A_pc1_mean, A_pc1_std);

x = min(A_princomp2):max(A_princomp2); % richtiges Intervall ?
A_pc2_pdf = pdf('Normal',x,A_pc2_mean, A_pc2_std);

x = min(A_princomp3):max(A_princomp3); % richtiges Intervall ?
A_pc3_pdf = pdf('Normal',x,A_pc3_mean, A_pc3_std);

x = min(A_princomp4):max(A_princomp4); % richtiges Intervall ?
A_pc4_pdf = pdf('Normal',x,A_pc4_mean, A_pc4_std);

x = min(A_princomp5):max(A_princomp5); % richtiges Intervall ?
A_pc5_pdf = pdf('Normal',x,A_pc5_mean, A_pc5_std);

x = min(A_princomp6):max(A_princomp6); % richtiges Intervall ?
A_pc6_pdf = pdf('Normal',x,A_pc6_mean, A_pc6_std);

x = min(A_princomp7):max(A_princomp7); % richtiges Intervall ?
A_pc7_pdf = pdf('Normal',x,A_pc7_mean, A_pc7_std);

x = min(A_princomp1):max(A_princomp1); % richtiges Intervall ?
A_pc8_pdf = pdf('Normal',x,A_pc8_mean, A_pc8_std);

x = min(A_princomp9):max(A_princomp9); % richtiges Intervall ?
A_pc9_pdf = pdf('Normal',x,A_pc9_mean, A_pc9_std);

x = min(A_princomp10):max(A_princomp10); % richtiges Intervall ?
A_pc10_pdf = pdf('Normal',x,A_pc10_mean, A_pc10_std);

x = min(A_princomp11):max(A_princomp11); % richtiges Intervall ?
A_pc11_pdf = pdf('Normal',x,A_pc11_mean, A_pc11_std);

x = min(A_princomp12):max(A_princomp12); % richtiges Intervall ?
A_pc12_pdf = pdf('Normal',x,A_pc12_mean, A_pc12_std);

x = min(A_princomp13):max(A_princomp13); % richtiges Intervall ?
A_pc13_pdf = pdf('Normal',x,A_pc13_mean, A_pc13_std);

x = min(A_princomp14):max(A_princomp14); % richtiges Intervall ?
A_pc14_pdf = pdf('Normal',x,A_pc14_mean, A_pc14_std);

x = min(A_princomp15):max(A_princomp15); % richtiges Intervall ?
A_pc15_pdf = pdf('Normal',x,A_pc15_mean, A_pc15_std);

x = min(A_princomp16):max(A_princomp16); % richtiges Intervall ?
A_pc16_pdf = pdf('Normal',x,A_pc16_mean, A_pc16_std);

A_pc1_aposteriori = A_pc1_pdf * A_x_apriori;
A_pc2_aposteriori = A_pc2_pdf * A_x_apriori;
A_pc3_aposteriori = A_pc3_pdf * A_x_apriori;
A_pc4_aposteriori = A_pc4_pdf * A_x_apriori;
A_pc5_aposteriori = A_pc5_pdf * A_x_apriori;
A_pc6_aposteriori = A_pc6_pdf * A_x_apriori;
A_pc7_aposteriori = A_pc7_pdf * A_x_apriori;
A_pc8_aposteriori = A_pc8_pdf * A_x_apriori;
A_pc9_aposteriori = A_pc9_pdf * A_x_apriori;
A_pc10_aposteriori = A_pc10_pdf * A_x_apriori;
A_pc11_aposteriori = A_pc11_pdf * A_x_apriori;
A_pc12_aposteriori = A_pc12_pdf * A_x_apriori;
A_pc13_aposteriori = A_pc13_pdf * A_x_apriori;
A_pc14_aposteriori = A_pc14_pdf * A_x_apriori;
A_pc15_aposteriori = A_pc15_pdf * A_x_apriori;
A_pc16_aposteriori = A_pc16_pdf * A_x_apriori;

% Hier jetzt 16 mal die FOR-schleife aus Teil 1 ? Uncool !!!

%%%%%%%%%%%%%%%%%%%%%%%%%%%  Aufgabe 3 (3 Punkte)  %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A 3.1: k-means auf die Daten clusters.txt anwenden,
%        k-means soll selbst implementiert werden!

k = 3;
numIterations = 5;

mean1 = C(1,:); % mean1, selected randomly
mean2 = C(2,:); % mean2, selected randomly
mean3 = C(3,:); % mean3, selected randomly
mean1_elems = []; % elements belonging to mean1
mean2_elems = []; % elements belonging to mean2
mean3_elems = []; % elements belonging to mean3
plotArray = [];

for iter=1:numIterations
    mean1_elems = [];
    mean2_elems = [];
    mean3_elems = [];
    for elem=1:size(C,1) % iterate over all elements
        dist = sqrt(abs(C(elem,1) - mean1(:,1))^2  + abs(C(elem,2) - mean1(:,2))^2);
        closest = mean1;
        dist2 = sqrt(abs(C(elem,1) - mean2(:,1))^2  + abs(C(elem,2) - mean2(:,2))^2);
        if dist > dist2
            closest = mean2;
            dist = dist2;
        end
        dist3 = sqrt(abs(C(elem,1) - mean3(:,1))^2  + abs(C(elem,2) - mean3(:,2))^2);
        if dist > dist3
            closest = mean3;
            dist = dist3;
        end
        if closest == mean1
            mean1_elems = vertcat(mean1_elems, C(elem, :));
        elseif closest == mean2
            mean2_elems = vertcat(mean2_elems, C(elem, :));
        else
            mean3_elems = vertcat(mean3_elems, C(elem, :));
        end
    end
    mean1_elems;
    mean2_elems;
    mean3_elems;
    mean1 = [mean(mean1_elems(:,1)), mean(mean1_elems(:,2))];
    mean2 = [mean(mean2_elems(:,1)), mean(mean2_elems(:,2))];
    mean3 = [mean(mean3_elems(:,1)), mean(mean3_elems(:,2))];
    
    % Visualisierung der Clusterzentren
    plotOfIteration = 5; % which iteration do we want to see a plot for?
    if iter == plotOfIteration
        % x = min(mean1_elems):max(mean1_elems)
        mean1_elems_x = mean1_elems(:,1); % x coordinates of all elements belonging to mean1
        mean1_elems_y = mean1_elems(:,2); % y coordinates of all elements belonging to mean1
        mean2_elems_x = mean2_elems(:,1);
        mean2_elems_y = mean2_elems(:,2);
        mean3_elems_x = mean3_elems(:,1);
        mean3_elems_y = mean3_elems(:,2);
        scatter(mean1_elems_x, mean1_elems_y, 40, [1 0 0])
        hold on
        scatter(mean1(:,1), mean1(:,2), 60, [.3 0 0], 'filled')
        hold on
        scatter(mean2_elems_x, mean2_elems_y, 40, [0 1 0])
        hold on
        scatter(mean2(:,1), mean2(:,2), 60, [0 .3 0], 'filled')
        hold on
        scatter(mean3_elems_x, mean3_elems_y, 40, [0 0 1])
        hold on
        scatter(mean3(:,1), mean3(:,2), 60, [0 0 .3], 'filled')
    end
end
