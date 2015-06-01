% Homework 05

% Clean up
clear all
close all
clc

% Datenaufbreitung
Data         = load('fisher.txt');
Data0        = Data((Data(:,3)==0),:);
Data1        = Data((Data(:,3)==1),:);
Koordinaten  = Data(:,1:2);
Koordinaten0 = Data((Data(:,3)==0),1:2);
Koordinaten1 = Data((Data(:,3)==1),1:2);
Klassen      = Data(:,3);

% Dimensionen
Data_n    = size(Data,2);
Data_m    = size(Data,1);
Data0_n   = size(Data0,2);
Data0_m   = size(Data0,1);
Data1_n   = size(Data1,2);
Data1_m   = size(Data1,1);

% Aufgabe 1

% Aufgabe 2

figure('NumberTitle','off','Name','Aufgabe 2 - Bildpunkte');
hold on
X      = Koordinaten(:,1);
Y      = Koordinaten(:,2);

% Punkte plotten
gscatter(X,Y,Klassen,'krb','+x',[],'off');

% Diskriminante erzeugen
FDK           = fitcdiscr(Koordinaten,Klassen); % Diskriminantenobjekt - erzeugt Klassifikator
Koeffizienten = FDK.Coeffs(1,2).Const;     % holt die konstanten Koeffizienten vom Klassifikator, die das LGS beschreiben
Linie         = FDK.Coeffs(1,2).Linear;    % holt die konstanten Koeffizienten vom Klassifikator, die das LGS beschreiben, also die Grenzlinie

% [x1,x2]*Linie + Koeffizienten = 0
f = @(x1) Linie(1)*x1 + Koeffizienten % y = mx + n

% Funktion plotten
Diskriminante = ezplot(f);
Diskriminante.Color = 'r';

xlabel('X-Koordinaten');
ylabel('Y-Koordinaten');